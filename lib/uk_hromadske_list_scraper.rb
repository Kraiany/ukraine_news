class UkHromadskeListScraper < ListScraper
  base_url "http://www.hromadske.tv"
  path "/ajax/type_newsline/action_allline/"

  day "css=ul", :iterator do
     news "css=li", :iterator do
        link 'xpath=.//a/@href'
        title 'css=span > a > strong'
     end
  end

  def process_result
    @result['day'].each do |day|
      day['news'].each do |article|
        link = article['link'].gsub 'http://www.hromadske.tv', ''
        article_class.find_or_create_by(relative_url: link) do |a|
          a.title = article['title']
          a.list_scraped_at = Time.zone.now
          a.state = 'unscraped'
        end
      end
    end
  end
end
