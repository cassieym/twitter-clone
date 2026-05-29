Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  resource :registration, only: [ :new, :create ]
  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, param: :token

  resources :tweets, only: [ :show, :create, :destroy ] do
    resources :likes, only: [ :create, :destroy ]
    resources :replies, only: [ :create ]
  end

  resources :users, only: [ :show, :edit, :update ] do
    resources :follows, only: [ :create, :destroy ]
  end
end
