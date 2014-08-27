require 'ua_pravda_list_scraper'
namespace :scrape do
  desc "Scrape list"
  task list: [:environment] do
    crawled = UaPravdaListScaper.new.crawl
    puts crawled
  end
end
