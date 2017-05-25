Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  devise_for :users

  get 'products/autocomplete', to: 'products#autocomplete'
  resources :products

  get 'positions/autocomplete', to: 'positions#autocomplete'
  resources :positions
end
