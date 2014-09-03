class HromadskeSerializer < ArticleSerializer
  def canonical_url
    "http://www.hromadske.tv#{object.relative_url}"
  end
end
