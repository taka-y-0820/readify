Rails.application.routes.draw do
  # Root path
  root "home#index"

  # Authentication routes
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get  "signup", to: "users#new"
  post "signup", to: "users#create"
  
  # Library (Books index)
  get "library", to: "books#index", as: :library
  
  # Books routes
  resources :books do
    collection do
      get :search
      post :add_from_google
    end
    resources :readings, only: [:create, :edit, :update, :destroy]
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Favicon route to prevent unnecessary errors
  get '/favicon.ico', to: ->(_) { [204, {}, []] }
end
