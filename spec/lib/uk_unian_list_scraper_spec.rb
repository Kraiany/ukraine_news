require 'rails_helper'

RSpec.describe UkUnianListScraper, :type => :feature do
  it "works" do
      source = "unian"
      base_class = source.classify.constantize
      scraper_class = "uk_#{source}_list_scraper".classify.constantize
      scraper_class.new(base_class.base_url, base_class.path).crawl
  end
end
