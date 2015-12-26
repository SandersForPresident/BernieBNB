Rails.application.routes.draw do
  root to: "home#sign_in"

  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  match "/signout" => "sessions#destroy", :as => :signout, via: [:delete]

  resources :visits, only: [:create, :destroy, :update]
  resources :hostings, only: [:create, :destroy, :update]
  resources :users, only: [:edit, :show, :update, :destroy]

  resources :users do
    resources :visits, only: [:new, :show, :index]
    resources :hostings, only: [:new, :show, :index]
  end
end
