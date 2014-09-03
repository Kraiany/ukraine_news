class UkEspresoListScraper < ListScraper
  base_url "http://espreso.tv"
  path "/news"

  day "css=body > div > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div.box_link.big_column > ul > ul", :iterator do
     news "css=li", :iterator do
        link 'xpath=.//h3//a/@href'
        title 'css=h3 a'
     end
  end
end
