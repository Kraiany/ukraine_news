require 'ua_pravda_list_scraper'
namespace :scrape do
  desc "Scrape list"
  task list: [:environment] do
    crawl_result = UaPravdaListScaper.new.crawl
  end
end
