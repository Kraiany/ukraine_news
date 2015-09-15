Rails.application.routes.draw do
  default_url_options :host => ENV['WEB_HOST']
  namespace :api do
    resources :articles, only: %w[index show], :defaults => { format: 'json' }
  end
  resources :articles, only: [:show, :index]
  resources :express, only: [:index]
  get '/express/articles/index' => 'express#index'
  get '/express/articles/:id' => 'express#show'

  get '/sitemap' => redirect("#{ENV['ASSET_URI']}/sitemaps/sitemap.xml.gz"), as: :sitemap

  root to: 'articles#index'
end
