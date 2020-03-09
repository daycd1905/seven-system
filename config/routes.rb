Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'

  get 'products/import'
  # get 'products/edit_product'
  # put 'products/update_product'
  get 'products/new_product'
  post 'products/create_product'
  resources :products


  get 'orders/index'
  post 'orders/report'
  get 'orders/find'
  # get 'orders/order_form_new'
  # post 'orders/create_order_form'
  resources :orders, :except => :show

end
