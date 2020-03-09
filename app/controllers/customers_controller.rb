class CustomerController < ApplicationController
    
    def create
        @customer = Customer.new(customer_params)
        @customer.save
    end

    def customer_params
        params.require(:customer).permit(:name, :phone)
    end

end