# config/routes.rb
require "sidekiq/web"

Rails.application.routes.draw do
  # 1. Protected Sidekiq Dashboard
 authenticate :user do
  mount Sidekiq::Web => "/sidekiq"
end

  # 2. Authentication Engines
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get "/admin/sign_in", to: "devise/sessions#new"
    post "/admin/sign_in", to: "devise/sessions#create"
  end

  # 3. Core SaaS Resources
  resource :profile, only: [ :show, :edit, :update ]
  post "stripe/webhooks", to: "stripe/webhooks#create"

  resources :subscriptions, only: [ :new, :create ] do
    get :success, on: :collection
    get :cancel, on: :collection
  end

  resources :posts do
    resources :comments
  end

  # 4. REST API Namespace
  namespace :api do
    namespace :v1 do
      resources :posts
      resources :users, only: [ :index ]
      post "/login", to: "auth#login"
    end
  end

  # 5. System, PWAs, and Infrastructure
  get "up" => "rails/health#show", as: :rails_health_check
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # 6. Application Root
  root "pages#home"
end