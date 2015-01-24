class ArticlesController < ApplicationController
  before_action :prepare_articles, only: [:index]
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
