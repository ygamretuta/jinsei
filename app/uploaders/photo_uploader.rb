# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  before :store, :remember_cache_id
  after :store, :delete_tmp_dir

  def remember_cache_id(new_file)
    @cache_id_was = cache_id
  end

  def delete_tmp_dir(new_file)
    if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
      FileUtils.rm_rf(File.join(cache_dir, @cache_id_was))
    end
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def cache_dir
    "uploads/#{model.class.to_s.underscore}/cache"
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def default_url
    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  # set max image size
  process :resize_to_limit => [800, 800]

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [90, 90]
  end

  version :medium do
    process :resize_to_fill => [300,250]
  end

  def filename
    @name ||= "#{Time.now.to_i}_#{super}.#{file.extension}" if original_filename.present? and super.present?
  end
end
