class OrderForm 

  include ActiveModel::Model 
  attr_accessor :customer_name
  attr_accessor :customer_phone
  attr_accessor :product_id
  attr_accessor :quantity

  validates :customer_name, presence: true
  validates :customer_phone, presence: true, length: {is: 10}, numericality: {only_integer: true}
  validates :quantity, presence: true, :numericality => {greater_than_or_equal_to: 1}

  def check    
    customer = Customer.create(name: customer_name, phone: customer_phone)
    binding.pry
    return customer unless customer.valid?
  end
end