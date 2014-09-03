class ArticleScaper
  include Wombat::Crawler
  attr_accessor :article

  def article_class
    @article_class ||= begin
      name.underscore.split('_')[1].classify.constantize
    end
  end

  def language
    @language ||= begin
      name.underscore.split('_').first
    end
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
