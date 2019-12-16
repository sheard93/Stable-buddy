Rails.application.routes.draw do
  devise_for :users
  root "info#index"
  resources :horses
  resources :lists, only: [:index, :new]
  resources :gallery, only: [:index]
    


end
