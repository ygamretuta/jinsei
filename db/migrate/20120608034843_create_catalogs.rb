class CreateCatalogs < ActiveRecord::Migration
  def up
    create_table :catalogs do |t|
      t.string :name
      t.text :description
      t.references :business
      t.string :slug

      t.timestamps
    end
    add_index :catalogs, :business_id, slug: :unique
  end

  def down
    drop_table :catalogs
  end
end
