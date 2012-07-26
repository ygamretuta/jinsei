class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.string :for
      t.boolean :approved, :default => false
      t.integer :reviewed_id
      t.integer :rating

      t.timestamps
    end
  end
end
