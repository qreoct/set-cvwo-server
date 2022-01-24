class Todo < ApplicationRecord
	has_many :assignments, dependent: :destroy
	has_many :users, through: :assignments
	accepts_nested_attributes_for :assignments

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	accepts_nested_attributes_for :taggings

	validates :title, presence: true
end
