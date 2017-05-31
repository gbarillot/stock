Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  devise_for :users

  get 'autocomplete/:topic', to: 'autocomplete#show'

  resources :products
  resources :positions
  resources :orders
  resources :users

  get  '/baskets/:order_id', to: 'baskets#show'
  post '/baskets/add', to: 'baskets#create'
  post '/baskets/remove', to: 'baskets#destroy'

  get  '/locations/:slug', to: 'locations#show'
end
