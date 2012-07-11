class AddApprovedToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :approved, :boolean
  end
end
