class SocialNotifier
  attr_accessor :article
  def initialize(args)
    @article = args.delete :article
  end

  def notify
    @article.did_tweet = true if tweet
    @article.save!
  end

  def can_tweet?
    !@article.did_tweet &&
      Time.current.beginning_of_day < @article.list_scraped_at && # TODO fix tweeting of old news
      @article.content.present?
  end

  private
    def tweet
      if can_tweet?
        result = twitter_client.update(tweet_content)
        Rails.logger.info "Tweeted #{result.uri}"
      end
    end

    def tweet_content
      "#{@article.title.try(:[], 0..116)} #{Rails.application.routes.url_helpers.article_url(@article)}"
    end

    def twitter_client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
      end
    end
end
