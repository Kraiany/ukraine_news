require 'dates_international'
class UkPravdaArticleScraper < ArticleScraper
  content "css=body > div.block0 > div.pad0 > div.fblock > div.block61 > div .text", :html
  published_at "css=body > div.block0 > div.pad0 > div.fblock > div.block61 > div > span.dt2"

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
      raw_content = result['content'].try('encode', 'utf-8')
      f = Nokogiri::HTML.fragment(raw_content)
      f.search("./p[contains(@class, 'tags')]/a").map(&:content)
    end
  end
end
