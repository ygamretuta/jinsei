class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps
    end

    add_index :categories, :slug, {:name => 'categories_slug_unique', :unique => true}

    add_column :products, :category_id, :integer, {:null => true}
  end
end