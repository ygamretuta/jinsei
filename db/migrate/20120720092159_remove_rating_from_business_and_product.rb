class RemoveRatingFromBusinessAndProduct < ActiveRecord::Migration
  def change
    remove_column :businesses, :rating
    remove_column :products, :rating
  end
end
