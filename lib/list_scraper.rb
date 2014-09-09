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
      name.underscore.split('_')[1].classify.constantize
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
        article_class.find_or_create_by(relative_url: article['link']) do |a|
          a.title = article['title']
          a.list_scraped_at = Time.zone.now
        end
      end
    end
  end
end
