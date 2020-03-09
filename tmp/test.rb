#"order"=>{"order_details_attributes"=>{"0"=>{"product_id"=>"1", "quantity"=>"1"}, 
# "1"=>{"product_id"=>"2", "quantity"=>"1"}}}, "commit"=>"Save"}



order = {"order_details_attributes" => {"0"=>{"product_id"=>"1", "quantity"=>"1"}, "1"=>{"product_id"=>"2", "quantity"=>"1"}}}

order["order_details_attributes"].each do |k, v|
	product_id = order["order_details_attributes"][k].first
	puts product_id[1]
end

