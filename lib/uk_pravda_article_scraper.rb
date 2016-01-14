require 'dates_international'
class UkPravdaArticleScraper < ArticleScraper
  content "css=body > div.layout > div.main-content > div > div > div.col__fluid > div > div > div.post_news__text", :html
  published_at "css=body > div.layout > div.main-content > div > div > div.col__fluid > div > div > div.post_news__date"
  tags_base "css=body > div.layout > div.main-content > div > div > div.col__fluid > div > div > div.post__tags", :html

  def published_at
    @published_at ||= begin
      short_date = result['published_at'].gsub(/^[^,]+, /, '')
      DateTime.parse_international("#{short_date} (EEST)")
    end
  end

  def content
    @content ||= begin
      raw_content = result['content'].try('encode', 'utf-8')
      f = Nokogiri::HTML.fragment(raw_content)
      f.search("./p[contains(@class, 'tags')]").remove
      f.to_s
    end
  end

  def tags
    @tags ||= begin
      raw_content = result['tags_base'].try('encode', 'utf-8')
      f = Nokogiri::HTML.fragment(raw_content)
      f.search("./span[contains(@class, 'post__tags__item')]/a").map(&:content)
    end
  end
end
