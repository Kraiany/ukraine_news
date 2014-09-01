class Article < ActiveRecord::Base
  before_save { state ||= 'unscraped' }
end
