class AddUserIdToBusiness < ActiveRecord::Migration
  def up
    change_table :businesses do |c|
        c.references :user
    end
  end

  def down
    change_table :businesses do |c|
      c.remove_references :user
    end
  end
end
