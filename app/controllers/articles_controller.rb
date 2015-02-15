class ArticlesController < ApplicationController
  before_action :prepare_articles, only: [:index]
  caches_action :show
  caches_action :index, :cache_path => proc { |c|
    p = ["articles"]
    p << params[:page] if params.has_key?(:page)
    p.join('-')
  }

  def index
  end

  def show
    if params[:id] && params[:id] != 'index'
      @article = Article.find params[:id]
    else
      prepare_articles
      render :index
    end
  end

  private
    def prepare_articles
      @articles = Article.published.page(params[:page])
    end
end
