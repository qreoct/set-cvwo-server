class User < ApplicationRecord
	has_many :todos, through: :assignments

  validates :name, presence: true
	validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4 }
end
