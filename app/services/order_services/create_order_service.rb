class CreateOrderService < ApplicationService
    
    attr_accessor :cus_params, :order_params

    def initialize(cus_params, order_params)
       @cus_params = cus_params
       @order_params = order_params
    end

    def check_valid(attr)
        od = OrderDetail.new(attr)
        return od unless od.valid?
    end
    

    def check_inventory 
        #if remained_lists not null thi` vuot qua so luong roll back
        remained_lists = []
        @order_params["order_details_attributes"].each do |k, v|

            array = @order_params["order_details_attributes"][k].values
            if array[1].to_i == 0
                return check_valid(@order_params["order_details_attributes"][k]) 
            end
            temp = Inventory.where("product_id = ? AND quantity >= ?", array[0], array[1]).take

            rescue Exception => e  
                return check_valid(@order_params["order_details_attributes"][k])
            else
            if temp.nil?                
                inv = Inventory.where(product_id: array[0])
                remained_lists.push(inv)
            end
          
        end
        return remained_lists
    end

    def merge_params
        @order_params["order_details_attributes"].each do |k, v|
            product_id_arr = @order_params["order_details_attributes"][k].to_unsafe_h.first   
            price_hash = Product.find_by("id = ?", product_id_arr[1]).attributes.slice('price')
            @order_params["order_details_attributes"][k].merge!(price_hash)
        end
    end

    def update_inventory
        @order_params["order_details_attributes"].each do |k, v|
            array = @order_params["order_details_attributes"][k].values
            enventory = Inventory.find_by("product_id = ?", array[0])
            enventory.update_attributes(quantity: (enventory.quantity - array[1].to_i))
        end 
    end

    def create     
        error_lists = check_inventory
        if error_lists.blank?
            @customer = Customer.where("phone = ?", @cus_params[:phone]).take
            if !@customer.present?
                @customer_new = Customer.new(@cus_params)
                @customer_new.save
                @customer = @customer_new
            end

            merge_params

            temp = @order_params.merge(:customer_id => @customer.id)

            @order = Order.new(temp)
            if @order.save
                update_inventory
                return error_lists           
            end
        else
            return error_lists
        end
    end
end