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
      crawler = "uk_#{source}_article_scraper".classify.constantize.new
      source.classify.constantize.unscraped.each do |article|
        crawler.article = article
        crawler.crawl
      end
    end
  end

  desc "Rescrape article for history"
  task rescrape: [:environment] do
    %w[pravda espreso hromadske].each do |source|
      crawler = "uk_#{source}_article_scraper".classify.constantize.new
      source.classify.constantize.needs_rescraping.each do |article|
        crawler.article = article
        crawler.crawl
      end
    end
  end

  desc "Runs scraper"
  task :all => ["scrape:list", "scrape:article", "scrape:rescrape"]
end
