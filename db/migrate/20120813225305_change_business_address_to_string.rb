class ChangeBusinessAddressToString < ActiveRecord::Migration
  def change
    change_column :businesses, :address, :string, {:default=>""}
  end
end