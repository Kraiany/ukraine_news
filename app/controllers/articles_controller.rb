class ArticlesController < ApplicationController
  def show
    if params[:id] && params[:id] != 'index'
      @article = Article.find params[:id]
    end
  end

  def sitemap
    @articles = Article.all
  end
end