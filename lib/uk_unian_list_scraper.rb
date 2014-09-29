class UkUnianListScraper < ListScraper
  day "css=body ul.main_all_news", :iterator do
     news "css=li", :iterator do
        link 'xpath=.//a/@href'
        title 'css=a'
     end
  end

  def process_result
    @result['day'].each do |day|
      day['news'].each do |article|
        next unless article['link']
        link = article['link'].gsub 'http://www.unian.ua', ''
        next if link =~ /^http/
        title = article['title'].gsub /^\d\d:\d\d/, ''
        article = article_class.new(relative_url: link, title: title, list_scraped_at: Time.zone.now)
        article.save
      end
    end
  end
end
