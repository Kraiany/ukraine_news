require 'rails_helper'

RSpec.describe Article, :type => :model do
  it "sets unique_identifier to relative_url on validation" do
    article = Article.new relative_url: '/some-url'
    article.valid?
    expect(article.unique_identifier).to eq('/some-url')
  end
end
