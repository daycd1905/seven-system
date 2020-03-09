class Customer < ActiveRecord::Base
    has_many :orders
    has_many :order_details, through: :orders

    validates :name, presence: true
    validates :phone, presence: true, length: {is: 10}, numericality: {only_integer: true}
end