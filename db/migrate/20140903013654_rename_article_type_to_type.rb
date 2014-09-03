class RenameArticleTypeToType < ActiveRecord::Migration
  def change
    rename_column :articles, :article_type, :type
  end
end
