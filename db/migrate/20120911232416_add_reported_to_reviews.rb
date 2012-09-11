class AddReportedToReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :type
    add_column :reviews, :reported, :boolean, {:default => false}
  end
end