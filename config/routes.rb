Rails.application.routes.draw do
  get 'sessions/new'
  resources :orders
  resources :products
  resources :items
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
