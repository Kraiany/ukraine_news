# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://#{ENV['WEB_HOST']}"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = ENV['ASSET_URI']
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  Article.published.find_each do |article|
    add article_path(article), lastmod: article.updated_at, changefreq: :monthly, priority: 0.7
  end
end
