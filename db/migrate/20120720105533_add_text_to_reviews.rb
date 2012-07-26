class AddTextToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :text, :text
    add_column :reviews, :title, :string, :default => 0
  end
end
