    class UpdateProductService < ApplicationService
        attr_accessor :id, :params

        def initialize(id, params)
            @id = id
            @params = params        
        end

        def update
            @product = Product.find(id)     
            if @product
                if @product.update(params)
                    return true
                else
                    return false
                end
            end
        end
    end