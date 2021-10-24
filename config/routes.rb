Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end
  root to: "babies#index"
  resources :babies, only: [:index, :new, :create] do
    resources :vaccination_lists, only: [:index]
    get :myfamily, on: :collection
  end
end