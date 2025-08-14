Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  root "rooms#index"

  resources :rooms, only: [:index, :show, :new, :create]
end