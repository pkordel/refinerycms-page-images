require 'image_attributes_parser'

module Refinery
  module PageImages
    module Extension
      def many_page_images
        has_many :image_pages, proc { order('position ASC') },
                 as: :page, class_name: 'Refinery::ImagePage'
        has_many :images, proc { order('position ASC') },
                 through: :image_pages, class_name: 'Refinery::Image'
        # accepts_nested_attributes_for MUST come before def images_attributes=
        # this is because images_attributes= overrides
        # accepts_nested_attributes_for.

        accepts_nested_attributes_for :images, allow_destroy: false

        # need to do it this way because of the way
        # accepts_nested_attributes_for deletes an already defined
        # images_attributes
        module_eval do
          def images_attributes=(params)
            data = params.reject { |_key, value| value.blank? }
            ids_to_keep = data.map { |_, d| d['image_page_id'] }.compact
            image_pages_to_delete(ids_to_keep).destroy_all
            update_or_create_image_pages(data)
          end

          def image_pages_to_delete(ids_to_keep)
            if ids_to_keep.empty?
              image_pages
            else
              image_pages
                .where(Refinery::ImagePage.arel_table[:id].not_in(ids_to_keep))
            end
          end

          def update_or_create_image_pages(data)
            objects = ImageAttributesParser.parse(data)
            objects.each do |obj|
              next if obj.image_id.blank?
              image_page = find_or_initialize_image_page(obj)
              image_page.position = obj.position
              image_page.caption = obj.caption if Refinery::PageImages.captions
              image_page.top_image = obj.top_image
              image_page.save
            end
          end

          def find_or_initialize_image_page(obj)
            if obj.image_page_id.present?
              image_pages.find(obj.image_page_id)
            else
              image_pages.build(image_id: obj.image_id)
            end
          end
        end

        include Refinery::PageImages::Extension::InstanceMethods
      end

      module InstanceMethods
        def caption_for_image_index(index)
          image_pages[index].try(:caption).presence || ''
        end

        def image_page_id_for_image_index(index)
          image_pages[index].try(:id)
        end

        def top_image
          candidate = image_pages.where(top_image: true).first
          candidate && candidate.image
        end

        def top_image_for_image_index(index)
          image_pages[index].try(:top_image)
        end

        def page_images
          image_pages.where(top_image: false)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Refinery::PageImages::Extension)
