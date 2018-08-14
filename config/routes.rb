Rails.application.routes.draw do
  resources :orders, only: [:index, :show, :update]
  resources :products
  resources :users

  resources :users, only: [:show] do
    resources :orders, only: [:index, :new, :show, :delete, :edit, :create, :update]
  end

  resources :products, only: [:show] do
    resources :orders, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete '/logout', to: "sessions#delete"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/', to: "users#home"
  put '/orders/fulfilled', to: "orders#fulfill_order"
  get '/auth/google_oauth2/callback', to: "sessions#create_google"
end
