class Article < ActiveRecord::Base
  has_paper_trail :on => [:update, :destroy], :ignore => %i[state updated_at next_scrape_at scrape_with_no_changes_count]
  before_save { state ||= 'unscraped' }
  scope :unscraped, -> { where(state: 'unscraped') }
  scope :scraped, -> { where(state: 'scraped') }
  scope :needs_rescraping, -> { where('(next_scrape_at < ? OR next_scrape_at IS NULL) AND state = ?', Time.zone.now, 'scraped')}
  after_initialize { self.next_scrape_at ||= 10.minutes.from_now }
  after_initialize { self.scrape_with_no_changes_count ||= 0 }
  before_save :mark_content_changes

  private
    def mark_content_changes
      self.scrape_with_no_changes_count = content_changed? ? 0 : (scrape_with_no_changes_count + 1)
      self.next_scrape_at = NextScrapeValue.new(scrape_with_no_changes_count).next_scrape_at
    end
end
