class UkRadioSvobodaArticleScraper < ArticleScraper
  content "css=.zoomMe", :html
  published_on "css=.article_date"

  def published_at
    @published_at ||= Time.zone.parse("#{result['published_at']} (EEST)") # FIXME: Fix and set proper published_at
  end
end
