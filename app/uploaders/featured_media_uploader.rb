# encoding: utf-8

class FeaturedMediaUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::RMagick
  include CarrierWaveDirect::Uploader
  include Sprockets::Rails::Helper
  process :set_content_type
  storage :file if Rails.env.development?
  version :thumb do
    process resize_to_fill: [60, 35]
  end

  def store_dir
    "featured_media/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
