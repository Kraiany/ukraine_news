class HomeController < ApplicationController
  def index
    if params[:article_id] && params[:article_id] != 'index'
      @article = Article.find params[:article_id]
    end
  end
end
