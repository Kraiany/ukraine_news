class UkHromadskeArticleScraper < ArticleScraper
  base_url "http://www.hromadske.tv"

  article do
    content "css=#page > div.main-two-columns.inner > section > article > div.text-wrapp", :html
  end

  def process_result
    scraped_article = @result["article"]
    @article.content = scraped_article["content"].encode('utf-8')
    @article.article_scraped_at = Time.zone.now
    @article.state = 'scraped'
    @article.save
  end
end
