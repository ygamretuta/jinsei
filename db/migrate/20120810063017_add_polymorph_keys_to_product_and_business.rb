class AddPolymorphKeysToProductAndBusiness < ActiveRecord::Migration
  def change
    add_column :reviews, :reviewable_id, :integer
    add_column :reviews, :reviewable_type, :string
    remove_column :reviews, :for
    remove_column :reviews, :reviewed_id
  end
end
