class Store < ActiveRecord::Base

	has_many :articles

	validates :name, presence: true, length: { minimum: 3 }
	validates :address, presence: true, length: { minimum: 5 }

end
