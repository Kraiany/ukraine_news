class ArticleScraper
  include Wombat::Crawler
  def initialize(base_url, path)
    super()
    self[:base_url] = base_url
    self[:path] = path
  end

  def crawl
    puts "Scraping #{self[:base_url]}#{self[:path]}"
    begin
      @result = super
    rescue Mechanize::ResponseCodeError => e
      puts e
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
end
