class Article < ActiveRecord::Base

	belongs_to :store

	# validation
	validates :name, presence: true, length: { minimum: 3 }
	validates :description, presence: true, length: { minimum: 5 }
	validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :total_in_shelf, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :total_in_vault, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
