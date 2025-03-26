class Profile < ApplicationRecord
	has_many :users
	serialize :permissions, Array
end
