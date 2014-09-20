class ArticleSerializer < ActiveModel::Serializer
  cached
  attributes :id, :title, :canonical_url, :content, :published_at, :source
  def source
    object.type
  end
end
