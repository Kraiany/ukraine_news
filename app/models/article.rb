class Article < ActiveRecord::Base
  before_save { state ||= 'unscraped' }
  scope :unscraped, -> { where(state: 'unscraped') }
end
