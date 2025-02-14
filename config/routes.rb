Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  resources :tweets, only: [ :create, :show ] do
    resources :likes, only: [ :create, :destroy ]
    resources :bookmarks, only: [ :create, :destroy ]
    resources :retweets, only: [ :create, :destroy ]
    resources :reply_tweets, only: [ :create ]
  end

  resources :bookmarks, only: :index

  get :dashboard, to: "dashboard#index"
  get :profile, to: "profile#show"
  put :profile, to: "profile#update"

  resources :usernames, only: [ :new, :update ]

  resources :users, only: :show do
    resources :followings, only: [ :create, :destroy ]
  end

  resources :hashtags, only: [ :index, :show ], path: "/explore"

  resources :message_threads, only: :index, path: "/messages"

  resources :messages, only: :create
end
