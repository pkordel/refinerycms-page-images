class AddTopImageToImagePages < ActiveRecord::Migration
  def change
    add_column Refinery::ImagePage.table_name, :top_image, :boolean,
               default: false
  end
end
