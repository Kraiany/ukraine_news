class AddNextScrapeAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :next_scrape_at, :datetime
    add_index :articles, :next_scrape_at
  end
end
