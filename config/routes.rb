Rails.application.routes.draw do
  resources :tweets, only: [:index]
  root to: 'tweets#index'
end
