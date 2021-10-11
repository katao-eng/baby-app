Rails.application.routes.draw do
  get 'vaccines/index'
  root to: "vaccines#index"
end
