	class CreateProductService < ApplicationService
		attr_accessor :params

		def initialize(params = {})
			@params = params	
		end

		def create 
			#params ok roi
			@product = Product.new(name: params[:name],price: params[:price])		
			if @product.save
				@inventory = Inventory.new(product: @product, quantity: 0)
				@inventory.save
				return @product
			end
		end
	end