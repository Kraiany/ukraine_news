require 'active_support'
require 'list_scraper'
require 'uk_pravda_list_scraper'
require 'uk_espreso_list_scraper'
require 'uk_pravda_article_scraper'
namespace :scrape do
  desc "Scrape list"
  task list: [:environment] do
    UkPravdaListScaper.new.crawl
    UkEspresoListScaper.new.crawl
  end

  desc "Scrape article"
  task article: [:environment] do
    crawler = UkPravdaArticleScaper.new
    Article.unscraped.each do |article|
      crawler.article = article
      crawler.crawl
    end
  end

  desc "Runs scraper"
  task :all => ["scrape:list", "scrape:article"]
end
