class ListScraper
  include Wombat::Crawler

  def initialize(base_url, path)
    super()
    self[:base_url] = base_url
    self[:path] = path
  end

  def crawl
    @result = super
    process_result
  end

  def article_class
    @article_class ||= begin
      name.underscore.gsub(/_list_scraper/, '')[3..-1].classify.constantize
    end
  end

  def language
    @language ||= begin
      name.underscore.split('_').first
    end
  end


  def process_result
    @result['day'].each do |day|
      day['news'].each do |article|
        next if article['link'] =~ /^http/
        article_class.create(relative_url: article['link'], title: article['title'], list_scraped_at: Time.zone.now)
      end
    end
  end
end
