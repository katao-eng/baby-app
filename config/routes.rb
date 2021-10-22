Rails.application.routes.draw do
  devise_for :users
  root to: "vaccination_lists#index"
  resources :babies, only: [:index, :new, :create]
  resources :vaccination_lists, only: [:index]
end
