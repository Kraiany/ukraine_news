require 'rails_helper'

RSpec.describe UkPravdaArticleScraper, :type => :feature do
  let(:base_url) { "http://www.pravda.com.ua/" }
  let(:relative_url) { "news/2014/09/29/7039242/" }
  subject(:scraper) {UkPravdaArticleScraper.new(base_url, relative_url)}
  it "gets content" do
    expect(scraper.content).to_not be_empty
  end

  it "gets published_at" do
    # Понеділок, 29 вересня 2014, 14:55
    expect(scraper.published_at).to eq Time.new(2014,9,29,14,55,0, "+03:00")
  end

  it "removes tags" do
    expect(scraper.content).to_not include 'tags'
  end

  it "gets tags" do
    pending 'find good article to scrape for test'
    expect(scraper.tags).to eq %w[Обама США Росія]
  end

  context "with photo media" do
    it "gets featured_media" do
      expect(scraper.featured_media).to eq "http://img.pravda.com/images/doc/4/d/4d5d3d2------.jpg"
    end
  end
end
