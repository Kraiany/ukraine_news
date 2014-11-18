class UkRadioSvobodaListScraper < ListScraper
  news "css=.news_textcolumn", :iterator do
    link 'xpath=.//a/@href'
    title 'css=a'
  end

  def process_result
    @result['news'].each do |article|
      next if article['link'] =~ /^http/
      puts "Creating #{article['link']}"
      article_class.create(relative_url: article['link'], title: article['title'], list_scraped_at: Time.zone.now)
    end
  end
end
