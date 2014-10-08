class ArticleScraper
  include Wombat::Crawler
  def initialize(base_url, path)
    super()
    self[:base_url] = base_url
    self[:path] = path
  end

  def crawl
    begin
      @result = super
    rescue Mechanize::ResponseCodeError => e
      puts e
      false
    end
  end

  def result
    @result ||= self.crawl
  end

  def content
    @content ||= result['content'].try 'encode', 'utf-8'
  end

  def published_at
    @published_at ||= Time.zone.parse("#{result['published_at']} (EEST)")
  end

  def featured_media
    @featured_media ||= begin
      raw_content = result['content'].try('encode', 'utf-8')
      f = Nokogiri::HTML.fragment(raw_content)
      if src = f.search('.//img').first.try(:[], 'src')
        src.match(/^http/) ? src : "#{self[:base_url]}#{src}"
      end
    end
  end
end
