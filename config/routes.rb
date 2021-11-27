Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
    get "guest_sign_in", :to => "users/sessions#guest_sign_in"
  end
  root to: "babies#index"
  resources :babies, only: [:index, :new, :create] do
    get :myfamily, on: :collection
    resources :vaccination_lists, only: [:index, :show, :edit, :update] do
      member do
        get 'set'
        patch 'generate'
        post 'generate'
        patch 'reset'
      end
    end
  end
end