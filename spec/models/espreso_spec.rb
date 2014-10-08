require 'rails_helper'

RSpec.describe Espreso, :type => :model do
  describe '#crawl', type: :feature do
    before do
      allow_any_instance_of(Espreso).to receive(:"remote_featured_media_url=").and_return(true)
    end
    let(:relative_url) { '/news/2014/10/08/v_donecku_boyovyky_zakhopyly_pryvatne_mebleve_pidpryyemstvo' }
    subject(:article) do
      article = Espreso.create relative_url: relative_url
      article.crawl
      article.save
      article.reload
      article
    end
    it "sets published_at" do
      expect(article.published_at).to eq Time.new(2014,10,8,14,8,0, "+03:00")
    end

    it "sets content" do
      expect(article.content).to be_present
    end

    it "gets relative_url" do
      expect(article.relative_url).to eq relative_url
    end
  end
end
