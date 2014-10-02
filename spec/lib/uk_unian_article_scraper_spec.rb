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

  it "gets published_at" do
    # 02.10.2014  | 07:21
    expect(scraper.published_at).to eq Time.new(2014,10,2,7,21,0, "+03:00")
  end

  it "replaces first h2 with p" do
    expect(scraper.content).to match /^<p>На дебатах ПАРЄ акцент в українському питанні змістився з російської агресії до внутрішніх проблем України./
  end
end
