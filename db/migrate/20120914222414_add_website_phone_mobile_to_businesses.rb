class AddWebsitePhoneMobileToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :website, :string, :default => nil
    add_column :businesses, :phone, :string, :default => nil
    add_column :businesses, :mobile, :string, :default => nil
  end
end
