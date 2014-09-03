class UkPravdaListScaper
  include Wombat::Crawler

  base_url "http://www.pravda.com.ua"
  path "/"

  day "css=body .block1 > .rpad .mnews1", :iterator do
     news "css=dd", :iterator do
        link 'xpath=./a/@href'
        title 'xpath=./a'
     end
  end

  def crawl
    @result = super
    process_result
  end

  def process_result
    @result['day'].each do |day|
      day['news'].each do |article|
        next if article['link'] =~ /^http/
        Article.find_or_create_by(relative_url: article['link']) do |a|
          a.title = article['title']
          a.list_scraped_at = Time.zone.now
          a.state = 'unscraped'
        end
      end
    end
  end
end
