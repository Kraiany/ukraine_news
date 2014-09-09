class UkHromadskeArticleScraper < ArticleScraper
  content "css=#page > div.main-two-columns.inner > section > article > div.text-wrapp", :html

  def published_at
    false
  end
end
