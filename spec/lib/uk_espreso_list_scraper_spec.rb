require 'rails_helper'
RSpec.describe UkEspresoListScraper, type: :feature do
  it do
    UkEspresoListScraper.new(Espreso.base_url, Espreso.path).crawl
    expect(Espreso.count).to eql 16
  end
end
