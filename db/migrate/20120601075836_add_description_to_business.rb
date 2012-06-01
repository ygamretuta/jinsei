class AddDescriptionToBusiness < ActiveRecord::Migration
  def up
    add_column :businesses, :description, :text
  end

  def down
    remove_column :businesses, :description
  end
end
