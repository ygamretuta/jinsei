class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :product_id
      t.text :feature

      t.timestamps
    end
  end
end
