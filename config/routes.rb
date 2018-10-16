Rails.application.routes.draw do
  resources :carts, only: [:show]
  resources :orders, only: [:index, :show, :update, :destroy]
  resources :products
  resources :users

  resources :users, only: [:show] do
    resources :orders, only: [:index, :new, :show, :destroy, :edit, :create, :update]
  end

  resources :products, only: [:show] do
    resources :orders, only: [:index, :show]
  end
  delete '/logout', to: "sessions#delete"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/', to: "users#home"
  post '/orders/:id/fulfilled', to: "orders#fulfill_order"
  get '/auth/google_oauth2/callback', to: "sessions#create_google"
  post '/carts', to: "carts#add_to_cart"
end
