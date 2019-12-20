Rails.application.routes.draw do
  devise_for :users
  root "info#index"
  resources :horses
  resources :items, only: [:index]
  resources :gallery, only: [:index]
    


end
