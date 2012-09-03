ActiveAdmin.register AdminUser do

  menu :if => proc { current_admin_user.role == 'superuser' }

  controller.authorize_resource

  filter :email
  filter :last_sign_in_at

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
    end
    f.buttons
  end

  show do |ad|
    attributes_table do
      row :email
    end
  end
end