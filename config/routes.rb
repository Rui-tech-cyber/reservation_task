Rails.application.routes.draw do
  root "rooms#index"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :rooms, only: [:index, :show, :new, :create] do
    resources :reservations, only: [:new, :create] 
    collection do
      get :search 
    end
  end

  resources :reservations, only: [:index, :show, :edit, :update, :destroy]

  resource :account, only: [:show], controller: "accounts"
end