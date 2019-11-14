Rails.application.routes.draw do
  devise_for :users
  root "info#index"
  resources :horses, only: [:index]

end
