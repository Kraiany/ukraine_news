require 'rails_helper'
RSpec.describe UkPravdaListScraper, type: :feature do
  it do
    UkPravdaListScraper.new(Pravda.base_url, Pravda.path).crawl
    expect(Pravda.count).to eql 56
  end
end
