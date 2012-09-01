class AddRoleToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :is_staff, :boolean, :default => false
  end
end