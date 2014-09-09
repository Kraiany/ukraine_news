class UkPravdaArticleScraper < ArticleScraper
  content "css=body > div.block0 > div.pad0 > div.fblock > div.block61 > div .text", :html
  published_at "css=body > div.block0 > div.pad0 > div.fblock > div.block61 > div > span.dt2"
end
