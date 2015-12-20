Rails.application.routes.draw do
  root to: "home#sign_in"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :visits
  resources :hostings
end
