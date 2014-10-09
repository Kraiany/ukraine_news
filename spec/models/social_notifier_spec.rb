require 'rails_helper'

RSpec.describe SocialNotifier, :type => :model do
  before do
    allow_any_instance_of(Twitter::REST::Client).to receive(:update).and_return(true)
  end
  it "tweets if content is present" do
    article = create :article
    expect(article.content).not_to be_nil
    expect(article.did_tweet).to be false
    notifier = SocialNotifier.new(article: article)
    expect(notifier).to receive(:tweet).and_return(:true)
    notifier.notify
    article.reload
    expect(article.did_tweet).to be true
  end

  it "does not tweeet if content is missing" do
    article = create :article, :empty
    expect(article.content).to be_nil
    expect(article.did_tweet).to be false
    notifier = SocialNotifier.new(article: article)
    expect(notifier).to receive(:tweet).and_return(nil)
    notifier.notify
    article.reload
    expect(article.did_tweet).to be false
  end

end
