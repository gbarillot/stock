Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  devise_for :users

  get 'products/autocomplete', to: 'products#autocomplete'
  resources :products

  get 'positions/autocomplete', to: 'positions#autocomplete'
  get 'positions/available', to: 'positions#available'
  resources :positions

  resources :orders
  resources :users

  get '/baskets/:order_id', to: 'baskets#show'
  post '/baskets/add', to: 'baskets#create'
  post '/baskets/remove', to: 'baskets#destroy'

  get '/locations/:slug', to: 'locations#show'
end
