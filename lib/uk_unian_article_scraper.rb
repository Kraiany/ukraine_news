class UkUnianArticleScraper < ArticleScraper
  content "css=.article_body", :html
  published_at "css=.central_article > .date"
end
