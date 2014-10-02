require 'dates_international'
class UkEspresoArticleScraper < ArticleScraper
  content "css=body > div.wrap_site > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div > div.col-9.w100.pr0 > div > div.first.text-page", :html
  published_date "css=body > div.wrap_site > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div > div.col-3.p0.w100 > div > div:nth-child(1)"
  published_time "css=body > div.wrap_site > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div > div.col-3.p0.w100 > div > div:nth-child(2)"

  def published_at
    @published_at ||= begin
      published_at_string = "#{result["published_date"]} #{result["published_time"]} (EEST)"
      DateTime.parse_international(published_at_string)
    end
  end

  def content
    @content ||= begin
      raw_content = result['content'].try('encode', 'utf-8')
      f = Nokogiri::HTML.fragment(raw_content)
      f.search(".//p[contains(@class, 'tags')]").remove
      f.to_s
    end
  end

  def tags
    @tags ||= begin
      raw_content = result['content'].try('encode', 'utf-8')
      f = Nokogiri::HTML.fragment(raw_content)
      f.search(".//p[contains(@class, 'tags')]/a").map(&:content)
    end
  end
end
