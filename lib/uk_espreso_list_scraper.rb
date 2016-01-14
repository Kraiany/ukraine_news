class UkEspresoListScraper < ListScraper
  day "css=body .news-list ul", :iterator do
     news "css=li", :iterator do
        link 'xpath=.//h3//a/@href'
        title 'css=h3 a'
     end
  end
end
