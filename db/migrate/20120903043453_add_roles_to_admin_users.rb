class AddRolesToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :role, :string, {:default => "staff"}
    remove_column :admin_users, :is_staff
  end
end