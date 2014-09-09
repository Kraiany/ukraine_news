class UkHromadskeListScraper < ListScraper
  day "css=ul", :iterator do
     news "css=li", :iterator do
        link 'xpath=.//a/@href'
        title 'css=span > a > strong'
        published_at 'css=span > span > span.subscribe > span.date'
     end
  end

  def process_result
    @result['day'].each do |day|
      day['news'].each do |article|
        link = article['link'].gsub 'http://www.hromadske.tv', ''
        article_class.find_or_create_by(relative_url: link) do |a|
          published_at_day = article['published_at'] =~ /вчора/ ? 1 : 0
          published_at = DateTime.parse("#{article['published_at']} (EEST)") - published_at_day.days
          a.title = article['title']
          a.list_scraped_at = Time.zone.now
          a.published_at = published_at
          a.state = 'unscraped'
        end
      end
    end
  end
end
