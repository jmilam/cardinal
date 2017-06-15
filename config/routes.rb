Rails.application.routes.draw do
  get 'main_menu/index'

  get 'login/index'
  delete 'login/destroy'
  post 'login/create'
  get 'login/edit'
  put 'login/update'
  
  get 'main_menu/print_function' => 'main_menu#print_function'
  get 'main_menu/new_tag' => 'main_menu#new_tag'
  get 'main_menu/skid_create_cartons' => 'main_menu#skid_create_cartons'
  get 'main_menu/carton_box_validation' => 'main_menu#carton_box_validation'
  get 'main_menu/add_cartons_to_skid' => 'main_menu#add_cartons_to_skid'
  get 'main_menu/ship_lines' => 'main_menu#ship_lines'
  get 'main_menu/get_product_lines' => 'main_menu#get_product_lines'
  get 'main_menu/item_lookup' => 'main_menu#item_lookup'
  get 'main_menu/tag_details' => 'main_menu#tag_details', as: :tag_details
  get 'main_menu/item_location' => 'main_menu#item_location', as: :item_location
  get 'main_menu/purchase_order_details' => 'main_menu#purchase_order_details', as: :purchase_order_details
  get 'main_menu/carton_function' => 'main_menu#carton_function', as: :carton_function
  post 'main_menu/process_function' => 'main_menu#process_function', as: :process_function
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'login#index'
end
