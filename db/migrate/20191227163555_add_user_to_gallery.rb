class AddUserToGallery < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_images, :user_id, :integer
    add_index :gallery_images, :user_id
  end
end
