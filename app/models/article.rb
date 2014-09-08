class Article < ActiveRecord::Base
  before_save { state ||= 'unscraped' }
  scope :unscraped, -> { where(state: 'unscraped') }
  scope :scraped, -> { where(state: 'scraped') }
  after_initialize { self.next_scrape_at ||= 10.minutes.from_now }
  after_initialize { self.scrape_with_no_changes_count ||= 0 }
end
