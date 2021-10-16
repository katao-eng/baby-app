Rails.application.routes.draw do
  devise_for :users
  get 'vaccines/index'
  root to: "vaccines#index"
end
