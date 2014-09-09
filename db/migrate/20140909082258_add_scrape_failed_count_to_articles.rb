class AddScrapeFailedCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :scrape_failed_count, :integer, default: 0
  end
end
