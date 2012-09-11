class AddReportedToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :reported, :boolean, {:default => false}
  end
end