namespace :carrierwave do
  desc "Clear cache dirs"
  task :clear_cache do
    CarrierWave.clean_cached_files!
  end
end