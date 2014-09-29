class Article < ActiveRecord::Base
  SOURCES = %w[pravda espreso hromadske unian]
  has_paper_trail :except => [:create], :ignore => %i[state article_scraped_at updated_at next_scrape_at scrape_with_no_changes_count content_change_count scrape_failed_count]
  before_save { state ||= 'unscraped' }
  scope :unscraped, -> { where(state: 'unscraped') }
  scope :scraped, -> { where(state: 'scraped') }
  scope :needs_scraping, -> { where('articles.next_scrape_at < ? OR articles.next_scrape_at IS NULL', Time.zone.now)}
  after_initialize { self.next_scrape_at ||= Time.zone.now }
  after_initialize { self.scrape_with_no_changes_count ||= 0 }
  after_initialize { self.content_change_count ||= 0 }
  after_initialize { self.state ||= 'unscraped' }
  before_validation { self.unique_identifier = unique_identifier_string }
  validates_uniqueness_of :unique_identifier

  def self.base_url
    raise "Undefined"
  end

  def self.path
    '/'
  end

  def self.is_scraping?
    scrape_check_cutoff_at = (ENV['SCRAPE_CHECK_HOURS'].present? ? ENV['SCRAPE_CHECK_HOURS'].to_i : 36).hours.ago
    self.scraped.where('article_scraped_at > ?', scrape_check_cutoff_at).any?
  end

  def crawl
    if article_scraper.crawl
      self.content = article_scraper.content if article_scraper.content
      if content_changed?
        self.content_change_count += 1
        self.scrape_with_no_changes_count = 0
      else
        self.scrape_with_no_changes_count += 1
      end
      self.published_at = article_scraper.published_at if article_scraper.published_at
      self.article_scraped_at = Time.zone.now
      self.scrape_failed_count = 0
      self.next_scrape_at = NextScrapeValue.new(scrape_with_no_changes_count).next_scrape_at
      self.state = 'scraped'
      true
    else
      self.content_change_count = 0
      self.scrape_with_no_changes_count = 0
      self.scrape_failed_count += 1
      self.next_scrape_at = NextScrapeValue.new(scrape_failed_count).next_scrape_at
      self.state = 'failed'
      false
    end
  end

  def article_scraper
    @article_scraper ||= article_scraper_class.new(self.class.base_url, relative_url)
  end

  def article_scraper_class
    @article_scraper_class ||= "Uk#{self.class.name}ArticleScraper".constantize
  end

  def canonical_url
    self.class.base_url + relative_url
  end

  def unique_identifier_string
    relative_url
  end
end
