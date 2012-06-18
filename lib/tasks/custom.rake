namespace :carrierwave do
  desc "Clear cache dirs"
  task :clear_cache do
    CarrierWave.clean_cached_files!
  end
end

namespace :fid do
  desc "Update slug of existing records"
  task :slug => :environment do
    Business.find_each(&:save)
    Product.find_each(&:save)
    Catalog.find_each(&:save)
  end
end