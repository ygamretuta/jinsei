class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
  end

  def down
    remove_column :users, :username
  end
end
