require 'dates_international'
class UkEspresoArticleScraper < ArticleScraper
  base_url "http://espreso.tv"

  article do
    content "css=body > div.wrap_site > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div > div.col-9.w100.pr0 > div > div.first.text-page", :html
    published_date "css=body > div.wrap_site > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div > div.col-3.p0.w100 > div > div:nth-child(1)"
    published_time "css=body > div.wrap_site > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div > div.col-3.p0.w100 > div > div:nth-child(2)"
  end

  def process_result
    scraped_article = @result["article"]
    @article.content = scraped_article["content"].encode('utf-8')
    published_at_string = "#{scraped_article["published_date"]} #{scraped_article["published_time"]}:00 +0200"
    @article.published_at = DateTime.parse_international(published_at_string)
    @article.article_scraped_at = Time.zone.now
    @article.state = 'scraped'
    @article.save
  end
end
