class Horse < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :photos
  
end
