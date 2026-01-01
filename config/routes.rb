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

  resource :account, only: [:show, :edit, :update]
  resource :mypage, only: [:show]
  resource :profile, only: [:edit, :update]

  resources :rooms do
    collection do
      get :mine
    end

    resources :reservations, only: [:new, :create] do
      collection do
        post :confirm
      end
    end
  end

  resources :reservations, only: [:index, :show, :destroy]

end