require 'active_support'
require 'list_scraper'
require 'article_scraper'
require 'uk_pravda_list_scraper'
require 'uk_pravda_article_scraper'
require 'uk_espreso_list_scraper'
require 'uk_espreso_article_scraper'
require 'uk_hromadske_list_scraper'
require 'uk_hromadske_article_scraper'
namespace :scrape do
  desc "Scrape list"
  task list: [:environment] do
    UkPravdaListScraper.new.crawl
    UkEspresoListScraper.new.crawl
    UkHromadskeListScraper.new.crawl
  end

  desc "Scrape article"
  task article: [:environment] do
    %w[pravda espreso hromadske].each do |source|
      source.classify.constantize.needs_scraping.each do |a|
        a.crawl
        a.save
      end
    end
  end

  desc "Runs scraper"
  task :all => ["scrape:list", "scrape:article"]
end
