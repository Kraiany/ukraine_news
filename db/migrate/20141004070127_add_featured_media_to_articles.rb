class AddFeaturedMediaToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :featured_media, :string
  end
end
