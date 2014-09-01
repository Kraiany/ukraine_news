require 'ua_pravda_list_scraper'
require 'ua_pravda_article_scraper'
namespace :scrape do
  desc "Scrape list"
  task list: [:environment] do
    UaPravdaListScaper.new.crawl
  end

  desc "Scrape article"
  task article: [:environment] do
    crawler = UaPravdaArticleScaper.new
    Article.unscraped.each do |article|
      crawler.article = article
      crawler.crawl
    end
  end
end
