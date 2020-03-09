class Order < ActiveRecord::Base
    has_many :order_details, dependent: :destroy
    has_many :products, through: :order_details
    belongs_to :customer, optional: true
    accepts_nested_attributes_for :order_details    
end