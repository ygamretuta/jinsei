class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.references :business

      t.timestamps
    end
    add_index :products, :business_id
  end
end
