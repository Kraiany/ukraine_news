class Article < ActiveRecord::Base
  before_save { state ||= 'unscraped' }
  scope :unscraped, -> { where(state: 'unscraped') }
  scope :scraped, -> { where(state: 'scraped') }
  after_initialize { self.next_scrape_at ||= 10.minutes.from_now }
end
