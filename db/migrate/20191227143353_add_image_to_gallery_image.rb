class AddImageToGalleryImage < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_images, :image, :string
  end
end
