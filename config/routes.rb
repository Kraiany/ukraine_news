Rails.application.routes.draw do
  namespace :api do
    resources :articles, only: %w[index show], :defaults => { format: 'json' }
  end
  resources :articles, only: [:show]

  root to: 'home#index'
end
