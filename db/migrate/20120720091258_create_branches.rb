class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :location
      t.integer :business_id

      t.timestamps
    end
  end
end
