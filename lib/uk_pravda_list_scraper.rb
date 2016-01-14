class UkPravdaListScraper < ListScraper
  news "css=body .block_news .article", :iterator do
    link 'xpath=.//a/@href'
    title 'xpath=.//a'
  end

  def process_result
    @result['news'].each do |article|
      next if article['link'] =~ /^http/
      article_class.create(relative_url: article['link'], title: article['title'], list_scraped_at: Time.zone.now)
    end
  end
end
