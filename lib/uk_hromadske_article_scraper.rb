class UkHromadskeArticleScraper < ArticleScraper
  content "css=#page > div.main-two-columns.inner > section > article > div.text-wrapp", :html
  featured_media "css=article > div.article-media", :html

  def published_at
    false
  end

  def featured_media
    @featured_media ||= begin
      media_in_wrapper = begin
        raw_content = result['featured_media'].try('encode', 'utf-8')
        f = Nokogiri::HTML.fragment(raw_content)
        if src = f.search('./img').first.try(:[], 'src').try(:gsub, /^\//, '')
          src.match(/^http/) ? src : "#{self[:base_url]}#{src}"
        end
      end || super
    end
  end
end
