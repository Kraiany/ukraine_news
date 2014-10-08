Rails.application.routes.draw do
  default_url_options :host => ENV['WEB_HOST']
  namespace :api do
    resources :articles, only: %w[index show], :defaults => { format: 'json' }
  end
  resources :articles, only: [:show, :index]

  get '/sitemap' => "articles#sitemap", :defaults => { :format => 'json' }

  root to: 'articles#index'
end
