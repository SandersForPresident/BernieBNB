Rails.application.routes.draw do
  root to: "home#sign_in"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :visits
  resources :hostings
  resources :users, only: [:edit, :update]
  
  resources :users do
    resources :visits, only: [:new, :show, :index]
    resources :hostings, only: [:new, :show, :index]
  end
end
