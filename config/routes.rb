Rails.application.routes.draw do
  get 'main_menu/index'

  get 'login/index'
  delete 'login/destroy'
  post 'login/create'

  get 'main_menu/tag_details' => 'main_menu#tag_details', as: :tag_details
  get 'main_menu/item_location' => 'main_menu#item_location', as: :item_location
  get 'main_menu/print_function' => 'main_menu#print_function'
  get 'main_menu/new_tag' => 'main_menu#new_tag'
  post 'main_menu/process_function' => 'main_menu#process_function', as: :process_function
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'login#index'
end