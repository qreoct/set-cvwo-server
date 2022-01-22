class Todo < ApplicationRecord
	has_many :users, through: :assignments

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

	validates :name, presence: true

end
