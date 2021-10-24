Rails.application.routes.draw do
  devise_for :users
  root to: "babies#index"
  resources :babies, only: [:index, :new, :create] do
    resources :vaccination_lists, only: [:index]
    get :myfamily, on: :collection
  end
end