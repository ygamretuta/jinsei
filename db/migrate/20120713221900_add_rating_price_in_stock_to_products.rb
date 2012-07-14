class AddRatingPriceInStockToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rating, :integer, :default => 0
    add_column :products, :in_stock, :boolean, :default => true
    add_column :products, :price, :decimal
  end
end
