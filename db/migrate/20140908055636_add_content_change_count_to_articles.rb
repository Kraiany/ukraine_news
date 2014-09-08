class AddContentChangeCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :content_change_count, :integer, default: 0
  end
end
