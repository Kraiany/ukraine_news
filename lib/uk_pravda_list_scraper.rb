class UkPravdaListScaper < ListScraper
  base_url "http://www.pravda.com.ua"
  path "/"

  day "css=body .block1 > .rpad .mnews1", :iterator do
     news "css=dd", :iterator do
        link 'xpath=./a/@href'
        title 'xpath=./a'
     end
  end
end
