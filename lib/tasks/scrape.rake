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
    Article::SOURCES.each do |source|
      base_class = source.classify.constantize
      scraper_class = "uk_#{source}_list_scraper".classify.constantize
      begin
        scraper_class.new(base_class.base_url, base_class.path).crawl
      rescue Exception => e
        Rails.logger.error "Error scraping source #{source}: #{e.message}"
      end
    end
  end

  desc "Scrape article"
  task article: [:environment] do
    Article::SOURCES.each do |source|
      source.classify.constantize.needs_scraping.limit(50).each do |a|
        begin
          a.crawl
          if a.save
            notifier = SocialNotifier.new(article: a)
            notifier.notify if notifier.can_tweet?
          end
        rescue Exception => e
          Rails.logger.error "Error scraping article #{a.id}: #{e.message}"
        end
      end
    end
  end

  desc "Snitch to confirm articles are being scraped"
  task snitch: [:environment] do
    Article::SOURCES.each do |source|
      raise "Not Scraping: #{source}" unless source.classify.constantize.is_scraping?
    end
  end

  desc "Runs `Rails.cache.clear`"
  task clear_rails_cache: [:environment] do
    Rails.cache.clear
  end

  desc "Runs scraper"
  task :all => ["scrape:list", "scrape:article", 'sitemap:refresh', 'scrape:clear_rails_cache'] # TODO: clear only specific article cache
end
