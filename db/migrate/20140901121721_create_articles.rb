class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :article_type
      t.string :relative_url
      t.text :content
      t.string :state
      t.datetime :list_scraped_at
      t.datetime :article_scraped_at

      t.timestamps
    end
    add_index :articles, :article_type
    add_index :articles, :state
  end
end
