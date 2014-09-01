class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :canonical_url, :content, :published_at
  def canonical_url
    "http://www.pravda.com.ua#{object.relative_url}"
  end
end
