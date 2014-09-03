class PravdaSerializer < ArticleSerializer
  def canonical_url
    "http://www.pravda.com.ua#{object.relative_url}"
  end
end
