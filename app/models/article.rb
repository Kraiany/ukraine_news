class Article < ActiveRecord::Base
  has_paper_trail :except => [:create], :ignore => %i[state article_scraped_at updated_at next_scrape_at scrape_with_no_changes_count content_change_count]
  before_save { state ||= 'unscraped' }
  scope :unscraped, -> { where(state: 'unscraped') }
  scope :scraped, -> { where(state: 'scraped') }
  scope :needs_rescraping, -> { where('(next_scrape_at < ? OR next_scrape_at IS NULL) AND state = ?', Time.zone.now, 'scraped')}
  after_initialize { self.next_scrape_at ||= 10.minutes.from_now }
  after_initialize { self.scrape_with_no_changes_count ||= 0 }
  after_initialize { self.content_change_count ||= 0 }
  before_save :mark_content_changes

  def self.base_url
    raise "Undefined"
  end

  def crawl
    if article_scraper.crawl
      self.content = article_scraper.content if article_scraper.content
      self.published_at = article_scraper.published_at if article_scraper.published_at
      self.article_scraped_at = Time.zone.now
      self.state = 'scraped'
    end
  end

  def article_scraper
    @article_scraper ||= article_scraper_class.new(self.class.base_url, relative_url)
  end

  def article_scraper_class
    @article_scraper_class ||= "Uk#{self.class.name}ArticleScraper".constantize
  end

  private
    def mark_content_changes
      if content_changed?
        self.content_change_count += 1
        self.scrape_with_no_changes_count = 0
      else
        self.scrape_with_no_changes_count += 1
      end
      self.next_scrape_at = NextScrapeValue.new(scrape_with_no_changes_count).next_scrape_at
    end
end
