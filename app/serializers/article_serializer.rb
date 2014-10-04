class ArticleSerializer < ActiveModel::Serializer
  cached
  attributes :id, :title, :canonical_url, :content, :published_at, :source, :featured_media
  def source
    object.type
  end

  def featured_media
    object.featured_media_url(:thumb)
  end
end
