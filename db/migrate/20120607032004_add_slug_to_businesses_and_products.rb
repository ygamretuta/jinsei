class AddSlugToBusinessesAndProducts < ActiveRecord::Migration
  def up
    add_column :businesses, :slug, :string
    add_column :products, :slug, :string

    add_index :businesses, :slug, unique: true
    add_index :products, :slug, unique: true
  end

  def down
    remove_index :businesses, :slug
    remove_index :products, :slug
    remove_column :businesses, :slug
    remove_column :products, :slug
  end
end
