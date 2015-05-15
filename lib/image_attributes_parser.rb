ImagePageVO = Struct.new(:image_id, :image_page_id, :position,
                         :top_image, :caption)

class ImageAttributesParser
  def self.parse(params = [])
    return if params.empty?
    data = params.dup.sort
    top_image_page_id = top_image_from(data)
    data.each_with_object([]) do |(k, v), ary|
      position = k
      image_id, image_page_id, caption =
        v.values_at('id', 'image_page_id', 'caption')
      top_image = top_image_page_id.present? &&
                  image_page_id == top_image_page_id
      ary << ImagePageVO.new(image_id, image_page_id, position,
                             top_image, caption)
    end
  end

  def self.top_image_from(data)
    data.last[-1].key?('top_image') && data.pop[-1]['top_image']
  end
end
