Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post "/", to: "pages#ho", as: "first_search"
  post "/restaurants", to: "restaurants#index"

  resources :users, only: [:show]
  resources :restaurants, only: %i[index show] do
    resources :slots, only: %i[index]
    resources :favourite_restaurants, only: %i[create]
    # resources :covers, only: %i[]
  end

  resources :covers, only: [] do
    resources :slots, only: %i[create]
  end
  resources :slots, only: [] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:destroy] do
    # confirmation doesn't need to be nested; could just call current_user.bookings.last on confirmation page
    get "confirmation", to: "bookings#confirmation", as: :confirmation
  end

  get "my_bookings", to: "bookings#my_bookings", as: :my_bookings
  resources :favourite_restaurants, only: %i[destroy]
end
