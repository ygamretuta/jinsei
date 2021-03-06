# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

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
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "uploads/#{model.class.to_s.underscore}/cache"
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def default_url
    asset_path([version_name, "default.gif"].compact.join('_'))
  end

  # set max image size
  process :resize_to_limit => [800, 800]

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [90, 90]
  end

  version :medium do
    process :resize_to_limit => [115,115]
  end

  version :large do
    process :resize_to_limit => [353, 300]
  end

  def filename
    @name ||= "#{Time.now.to_i}_#{super}" if original_filename.present? and super.present?
  end
end
