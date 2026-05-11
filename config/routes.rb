Rails.application.routes.draw do
  devise_for :users
  root "pages#main"

  get "about", to: "pages#about"
  get "help", to: "pages#help"
  resources :ratings, only: [:create]
  resource :user, only: [:show]

  namespace :api do
    resources :ratings, only: [:create]
  end
end
