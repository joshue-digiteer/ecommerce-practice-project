Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # User
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks',
    confirmations: 'users/confirmations',
    omniauth: 'users/omniauth'
  }

  # Product
  resources :products do
    # Order
    resources :orders, only: [:create, :update, :destroy]

    # Review
    resources :reviews, only: [:create, :update, :destroy]
  end

  # Cart
  resources :carts, only: [:show, :update, :destroy]

  # Payment
  resources :payments, only: [:index, :new, :create, :destroy]
    
  # Wish List
  resources :wish_lists, only: [:index, :create, :destroy]
end
