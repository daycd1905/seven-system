class CreateProductFormService < ApplicationService
    attr_accessor :params

    def initialize(params = {})
        @params = params	
    end

    def create 
        product = Product.create(name: params[:name], price: params[:price])
        product.create_inventory(product: product, quantity: params[:quantity])
    end
end