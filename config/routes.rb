Rails.application.routes.draw do
  namespace :api do
    resources :articles, only: %w[index show], :defaults => { format: 'json' }
  end
  get '/articles/:article_id' => 'home#index'

  root to: 'home#index'
end
