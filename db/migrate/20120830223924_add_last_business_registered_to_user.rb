class AddLastBusinessRegisteredToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_business_registered, :timestamp, {:null => true, :default => nil}
  end
end