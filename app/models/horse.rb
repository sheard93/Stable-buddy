class Horse < ApplicationRecord
  validates :name, presence: true
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  
 
  
end
