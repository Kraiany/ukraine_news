require 'rails_helper'

RSpec.describe UkEspresoArticleScraper, :type => :feature do
  let(:base_url) { "http://espreso.tv/" }
  let(:relative_url) { "news/2014/10/02/u_luhansku_ditey_novorosiyi_vzyalysya_vchyty_patriotyzmu_muzykoyu_sektora_hazu" }
  subject(:scraper) {UkEspresoArticleScraper.new(base_url, relative_url)}
  it "gets content" do
    expect(scraper.content).to_not be_empty
  end

  it "gets published_at" do
    # 2 ЖОВТНЯ, 2014 16:31
    expect(scraper.published_at).to eq Time.new(2014,10,2,16,31,0, "+03:00")
  end

  it "removes tags" do
    expect(scraper.content).to_not include 'tags'
  end

  it "gets tags" do
    expect(scraper.tags).to eq %w[ЛНР діти музика]
  end

  context "with photo media" do
    let(:relative_url) { "news/2014/10/02/patriotymz_zashkalyuye_v_ivano_frankivsku_stryptyzerky_tancyuyut_u_vyshyvankakh" }
    it "gets featured_media" do
      expect(scraper.featured_media).to eq "http://espreso.tv/uploads/article/75709/images/im578x383-40813822.jpg"
    end
  end
end
