Rails.application.routes.draw do
  resources :orders, only: [:index, :show]
  resources :products
  resources :users

  resources :users, only: [:show] do
    resources :orders, only: [:index, :new, :show, :delete, :edit, :create]
  end

  resources :products, only: [:show] do
    resources :orders, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete '/logout', to: "sessions#delete"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/', to: "users#home"
  patch '/orders/fulfilled', to: "orders#fulfill_order"
end
