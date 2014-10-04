require 'rails_helper'

RSpec.describe UkHromadskeArticleScraper, :type => :feature do
  let(:base_url) { "http://www.hromadske.tv/" }
  let(:relative_url) { "world/gonkong-tisyachi-lyudei-prodovzhuyut-perekrivati-t/" }
  subject(:scraper) {UkHromadskeArticleScraper.new(base_url, relative_url)}
  it "gets content" do
    expect(scraper.content).to_not be_empty
  end

  it "does not get published_at" do
    expect(scraper.published_at).to be false
  end

  context "with photo media" do
    it "gets featured_media" do
      expect(scraper.featured_media).to eq "http://www.hromadske.tv/images/doc/4/a/4ad9e3c---------------_628x420.jpg"
    end
  end
end
