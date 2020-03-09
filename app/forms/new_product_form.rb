class NewProductForm

  include ActiveModel::Model 

  attr_accessor :name, :price, :quantity

  validates :name, presence: true
	validates :price, presence: true, :numericality => {greater_than: 0}
  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}

  # def check
  #   return false unless valid?
  #   product = Product.create(name: name, price: price)
  #   inventory = Inventory.create(product: product, quantity: quantity)
  # end


end