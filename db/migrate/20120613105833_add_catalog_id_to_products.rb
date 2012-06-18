class AddCatalogIdToProducts < ActiveRecord::Migration
  def up
    add_column :products, :catalog_id, :integer
    add_index :products, :catalog_id
  end

  def down
    remove_index :products, :catalog_id
    remove_column :products, :catalog_id
  end
end
