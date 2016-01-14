require 'dates_international'
class UkEspresoArticleScraper < ArticleScraper
  content "css=body .articleContent .article", :html
  published_at "css=body .authorDate"
  featured_media "css=body > div.wrap_site > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div > div > div.photo-wrap", :html

  def published_at
    @published_at ||= short_date = DateTime.parse_international("#{result['published_at']} (EEST)")
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
      f.search(".//div[contains(@class, 'tags')]//a").map(&:content)
    end
  end

  def featured_media
    @featured_media ||= begin
      media_in_wrapper = begin
        raw_content = result['featured_media'].try('encode', 'utf-8')
        f = Nokogiri::HTML.fragment(raw_content)
        if src = f.search('.//img').first.try(:[], 'src').try(:gsub, /^\//, '')
          src.match(/^http/) ? src : "#{self[:base_url]}#{src}"
        end
      end || super
    end
  end
end
