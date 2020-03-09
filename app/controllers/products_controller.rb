class ProductsController < ApplicationController
	$LOAD_PATH << '.'
	require './app/services/product_services/create_product_service.rb'
	require './app/services/product_services/update_product_service.rb'
  require './app/services/product_services/check_inventory_service.rb'
  require './app/services/product_services/create_product_form_service.rb'

	def index
		@products = Product.all
		@inventories = CheckInventoryService.new.check
	end

	def new
		@product = Product.new
	end

  	def create		
    	# check validation in controller
		@product = Product.new(product_params)		
		respond_to do |format|
		if @product.valid?
			#???????
    	    flag = CreateProductService.new(product_params).create
    	    break if flag.nil?        
				format.html { redirect_to :action => 'index'}
			  	format.json { render :show, status: :created, location: @product }			  
			else
			  	format.html { render :new }
			  	format.json { render json: @product.errors, status: :unprocessable_entity }
			end			
		end
	end

	def edit
		@product = Product.where(id: params[:id].to_i).last
		unless @product
			render html: "<script>alert('This product do not existed!')</script>".html_safe		
		end
	end

	def import
		@imports = CheckInventoryService.new.check
	end



  def update
    @product = Product.find(params[:id])    
    # UpdateProductService.new(params[:id].to_i, product_params).update
    	respond_to do |format|
    	  if @product.update(product_params)
    	    format.html { redirect_to :action => 'index' }
			    format.json { render :show, status: :created, location: @product }			  
    	  else
    	    format.html { render :edit }
    	    format.json { render json: @product.errors, status: :unprocessable_entity }
    	  end
    	end
	end

	def product_params 
		params.require(:product).permit(:name, :price, inventory_attributes: [:id, :quantity])
  	end
  
  def new_product
	  @form = NewProductForm.new
  end

  def create_product
    @form = NewProductForm.new(new_product_params)
    respond_to do |format|
      if @form.valid?
        @form = CreateProductFormService.new(new_product_params).create        
        format.html { redirect_to :action => "index" }
      else
        format.html { render :new_product }
        format.json {render json: @form.errors }
      end 
    end
	end

  def new_product_params
	  params.require(:new_product_form).permit(:name, :price, :quantity)
  end

end