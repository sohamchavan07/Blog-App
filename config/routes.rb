Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/admin/sign_in", to: "devise/sessions#new"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  namespace :api do
    namespace :v1 do
      resources :posts
      resources :users, only: [ :index ]
      post "/login", to: "auth#login"
    end
  end

  resources :posts do
    resources :comments
  end

  # Defines the root path route ("/")
  root "posts#index"
end
