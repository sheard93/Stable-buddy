Rails.application.routes.draw do
  devise_for :users
  root "info#index"
  get "/list", to:"info#list"
  resources :horses
  resources :items, only: [:index, :update, :create]
  resources :gallery, only: [:index, :new]
    


end
