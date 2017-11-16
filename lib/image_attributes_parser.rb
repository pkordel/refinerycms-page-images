ImagePageVO = Struct.new(:image_id, :image_page_id, :position,
                         :top_image, :caption)

class ImageAttributesParser
  def self.parse(params)
    params_array = params.sort

    params_array.each_with_object([]) do |e, ary|
      position = e.first
      image_id, image_page_id, caption, top_image_page_id =
        e.last.values_at('id', 'image_page_id', 'caption', 'top_image')
      top_image =
        top_image_page_id.present? && top_image_page_id == image_page_id
      ary << ImagePageVO.new(image_id, image_page_id, position,
                             top_image, caption)
    end
  end
end
