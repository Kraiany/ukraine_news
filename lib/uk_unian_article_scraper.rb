class UkUnianArticleScraper < ArticleScraper
  content "css=.article_body", :html
  published_at "css=.central_article > .date"

  def content
    @content ||= begin
      raw_content = result['content'].try('encode', 'utf-8')
      f = Nokogiri::HTML.fragment(raw_content)
      f.search(".//*[contains(@class, 'read_also')]").remove
      f.search('./h2').first.try(:"name=", 'p')
      f.to_s
    end
  end
end
