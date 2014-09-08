class AddScrapeWithNoChangesCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :scrape_with_no_changes_count, :integer, default: 0
  end
end
