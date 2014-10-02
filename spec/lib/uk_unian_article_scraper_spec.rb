require 'rails_helper'

RSpec.describe UkUnianArticleScraper, :type => :feature do
  let(:base_url) { "http://www.unian.ua/" }
  let(:relative_url) { "politics/991464-pare-zaklikala-ukrajinu-provoditi-reformi-nezvajayuchi-na-viynu.html" }
  subject(:scraper) {UkUnianArticleScraper.new(base_url, relative_url)}
  it "gets content" do
    expect(scraper.content).to_not be_empty
  end
  it "removes read_also tag" do
    expect(scraper.content).to_not include 'read_also'
  end
end
