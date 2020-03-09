class OrdersController < ApplicationController

  require './app/services/order_services/create_order_service.rb'
  # require './app/forms/order_form.rb'
  def index
      @orders = Order.all        
  end

  def new
      @order = Order.new        
      @customer = Customer.new
      @products = Product.all
      @order.order_details.build
      @order.order_details.build
      @order_details = OrderDetail.new
  end
  def create
    # @customer = Customer.where("phone = ?", customer_params[:phone])
    # if !@customer.present?
    #     @customer_new = Customer.new(customer_params)
    #     @customer_new.save
    # end
    # # tmp = {:customer_id => @customer.pluck(:id).first}
    # # temp = tmp.merge(order_params)
    
    # temp = order_params.merge(:customer_id => @customer.pluck(:id).first)
    # @order = Order.new(temp)       
    # if @order.save
    #     redirect_to :action => 'new'
    # end


    # @remained_lists = CreateOrderService.new(customer_params, order_params).create
    # if @remained_lists.blank?
    #     redirect_to action: 'new'
    # else
    #     render html: "<script>alert('Sorry not enough enventory')</script>".html_safe
    # end   
    
#PART222222222222


    
    # @customer = Customer.new(customer_params)
    # @order = Order.new(order_params)
    # @order_details = OrderDetail.new

    # respond_to do |format|
    #   if @customer.valid?
    #     @remained_lists = CreateOrderService.new(customer_params, order_params).create
    #     if @remained_lists.blank?
    #       format.html { redirect_to :action => 'index'}
    #     elsif @remained_lists[0] 
    #       format.html { render :new}
    #       @remained_lists = true
    #     else
    #       @order_details = @remained_lists
    #       format.html {render :new}
    #       format.json {render json: @order_details.errors}
    #     end
    #   else
    #     format.html { render :new}
    #     format.json { render json: @customer.errors, status: :unprocessable_entity }
    #   end
    # end  


    @customer = Customer.new(customer_params)
    @order = Order.new(order_params)
    @order_details = OrderDetail.new
  
    respond_to do |format|
      if @customer.valid?
        if @order.valid?
          @remained_lists = CreateOrderService.new(customer_params, order_params).create
          if @remained_lists.blank?
            format.html { redirect_to :action => 'index'}
          end
        else
          format.html {render :new}
          format.json {render json: @order.errors}
        end
      else
        format.html { render :new}
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  


  def report
      @lists = OrderDetail.where(created_at: params[:start_date]..params[:end_date])
      .group(:product_id).order('sum_quantity DESC').sum(:quantity).first(2).to_h 
  end

  def order_params
      params.require(:order).permit(order_details_attributes: [:product_id, :quantity])
  end

  def customer_params
      params.require(:customer).permit(:name, :phone)
  end


  def order_form_params 
    params.require(:order_form).permit(:customer_name, :customer_phone, :product_id, :phone)
  end
end
