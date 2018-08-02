Rails.application.routes.draw do
  resources :orders
  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users/admin/:id', to: "users#admin_show", as: 'admin_user'
  get '/logout', to: "sessions#delete"
end
