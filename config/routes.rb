Rails.application.routes.draw do

  root 'home#index'

  devise_for :users

  get 'autocomplete/:topic', to: 'autocomplete#show'

  resources :products

  get 'positions/list/:slug', to: 'positions#list'
  resources :positions
  resources :orders
  resources :users

  get  '/baskets/:order_id', to: 'baskets#show'
  post '/baskets/add', to: 'baskets#create'
  post '/baskets/remove', to: 'baskets#destroy'
  put  '/baskets/:id', to: 'baskets#update'

  get  '/locations/:slug', to: 'locations#show'
  post '/locations', to: 'locations#create'
end
