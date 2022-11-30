Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post '/', to: 'pages#ho', as: 'first_search'
  post '/restaurants', to: 'restaurants#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:show]
  resources :restaurants, only: %i[index show] do
    resources :favourite_restaurants, only: %i[create destroy]
    resources :covers, only: [:create]
  end

  resources :covers, only: [] do
    resources :slots, only: %i[index create]
  end
  resources :slots, only: [] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:destroy] do
    get "confirmation", to: "bookings#confirm", as: :confirmation
  end
end
