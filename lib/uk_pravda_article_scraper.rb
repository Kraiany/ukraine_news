class UkPravdaArticleScaper
  include Wombat::Crawler
  attr_accessor :article

  base_url "http://www.pravda.com.ua"

  article do
    content "css=body > div.block0 > div.pad0 > div.fblock > div.block61 > div .text", :html
    published_at "css=body > div.block0 > div.pad0 > div.fblock > div.block61 > div > span.dt2"
  end

  def crawl
    self[:path] = @article.relative_url
    puts "Scraping #{self[:base_url]}#{self[:path]}"
    @result = super
    process_result
  end

  def process_result
    scraped_article = @result["article"]
    @article.content = scraped_article["content"].encode('utf-8')
    @article.published_at = Time.parse(scraped_article["published_at"]) if scraped_article["published_at"].present?
    @article.article_scraped_at = Time.zone.now
    @article.state = 'scraped'
    @article.save
  end
end
