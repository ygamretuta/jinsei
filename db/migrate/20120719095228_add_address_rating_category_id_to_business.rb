class AddAddressRatingCategoryIdToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :address, :text
    add_column :businesses, :rating, :integer
    add_column :businesses, :category_id, :integer
  end
end
