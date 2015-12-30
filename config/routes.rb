Rails.application.routes.draw do
  resources :contacts
  root to: "home#sign_in"

  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  match "/signout" => "sessions#destroy", :as => :signout, via: [:delete]
  match "/auth/failure" => "home#sign_in", via: [:get, :post]

  resources :visits, only: [:create, :destroy, :update, :show, :edit]
  resources :hostings, only: [:create, :destroy, :edit, :update]
  resources :users, only: [:edit, :show, :update, :destroy]

  resources :users do
    resources :visits, only: [:new, :index]
    resources :hostings, only: [:new, :index]
  end
end
