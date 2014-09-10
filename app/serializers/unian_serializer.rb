class UnianSerializer < ArticleSerializer
  def canonical_url
    "http://www.unian.ua#{object.relative_url}"
  end
end
