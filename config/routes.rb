Rails.application.routes.draw do

  root "sessions#new"

  get    "/login",    to: "sessions#new"
  post   "/login",    to: "sessions#create"
  delete "/logout",   to: "sessions#destroy"

  get  "/register", to: "users#new"
  post "/users",    to: "users#create"

  resources :movies do
    resources :shows, only: [ :new, :create ]
  end

  resources :shows, only: [] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
