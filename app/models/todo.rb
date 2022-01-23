class Todo < ApplicationRecord
	has_many :assignments, dependent: :destroy
	has_many :users, through: :assignments

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

	validates :title, presence: true
end
