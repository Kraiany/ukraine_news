class UkEspresoListScaper
  include Wombat::Crawler

  base_url "http://espreso.tv"
  path "/news"

  day "css=body > div > section > div > div.row.mr0 > div.col-8.w50-big-col.left-col.pr0 > div.box_link.big_column > ul > ul", :iterator do
     news "css=li", :iterator do
        link 'xpath=.//h3//a/@href'
        title 'css=h3 a'
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
