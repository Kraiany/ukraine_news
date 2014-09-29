class AddUniqueIdentifierToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :unique_identifier, :string
    add_index :articles, :unique_identifier, unique: true
    Article.all.each do |article|
      article.unique_identifier = article.unique_identifier_string
      article.save
    end
  end
  def down
    remove_column :articles, :unique_identifier
  end
end
