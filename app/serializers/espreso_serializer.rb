class EspresoSerializer < ArticleSerializer
  def canonical_url
    "http://espreso.tv#{object.relative_url}"
  end
end
