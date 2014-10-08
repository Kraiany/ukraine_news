class AddDidTweetToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :did_tweet, :boolean, default: false
  end
end
