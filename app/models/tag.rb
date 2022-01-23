class Tag < ApplicationRecord
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :todos, through: :taggings
  
  validates :name, presence: true, uniqueness: true
end
