require 'rails_helper'

RSpec.describe Unian, :type => :model do
  it "sets unique_identifier to unian article id on validation" do
    article = Unian.new relative_url: '/header/12345-some-url'
    article.valid?
    expect(article.unique_identifier).to eq('Unian-12345')
  end

  it "sets unique_identifier to nil when no article id found" do
    article = Unian.new relative_url: '/header/some-url'
    article.valid?
    expect(article.unique_identifier).to eq(nil)
  end
end
