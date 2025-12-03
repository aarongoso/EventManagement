Rails.application.routes.draw do
   # devise_for :users  # removed because using simpler email based auth (following labs)
   # RESTful routes for all main models — Users, Events, and Bookings
   # These automatically create all CRUD routes (index, show, new, edit, create, update, destroy)
   # These define the RESTful routes for CRUD operations across Users, Events, and Bookings
   # resources :users, only: [:index]
   resources :bookings
   resources :events
   resources :users

  # Endpoint for sending booking confirmation emails
  post "/send_confirmation", to: "email#send_confirmation"

  # Letter Opener route for viewing email previews (used instead of real SMTP in development labs)
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Health check route — used by Rails to verify the app boots correctly
  get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    # Set the homepage of the application to show all Events
    # This means visiting http://localhost:3000/ will display the Events index view
    root "events#index"
end
