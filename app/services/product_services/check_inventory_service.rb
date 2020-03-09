
    class CheckInventoryService < ApplicationService    
        def initialize


        end

        def check
            @products = Product.joins(:inventory).where("inventories.quantity <= 2")
            return @products
        end
    end