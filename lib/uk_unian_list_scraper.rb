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
        article_class.find_or_create_by(relative_url: link) do |a|
          a.title = article['title'].gsub /^\d\d:\d\d/, ''
          a.list_scraped_at = Time.zone.now
        end
      end
    end
  end
end
