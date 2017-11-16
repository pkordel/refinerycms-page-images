ImagePageVO = Struct.new(:image_id, :image_page_id, :position,
                         :top_image, :caption)

class ImageAttributesParser
  def self.parse(params)
    params_array = params.sort
    top_image_page_id = if params_array.last.present? &&
                           params_array.last[-1].key?('top_image')
                          params_array.pop[-1]['top_image']
                        end

    params_array.each_with_object([]) do |e, ary|
      position = e.first
      image_id, image_page_id, caption =
        e.last.values_at('id', 'image_page_id', 'caption')
      top_image = image_page_id == top_image_page_id
      ary << ImagePageVO.new(image_id, image_page_id, position,
                             top_image, caption)
    end
  end
end
