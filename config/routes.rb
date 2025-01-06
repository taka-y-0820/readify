Rails.application.routes.draw do
  # Root path
  root "home#index"

  # Devise routes for user authentication
  devise_for :users

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Favicon route to prevent unnecessary errors
  get '/favicon.ico', to: ->(_) { [204, {}, []] }

  # Optional: PWA-related routes (uncomment if necessary)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
