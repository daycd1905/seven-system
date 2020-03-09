class Product < ActiveRecord::Base
	has_one :inventory
	accepts_nested_attributes_for :inventory

	validates :name, presence: true
	validates :price, presence: true, :numericality => {greater_than: 0}
end 