ActiveAdmin.register User do
  filter :username

  index do
    column :username
    column :email
    column :role
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :username
      f.input :banned
      f.input :role, :as => :select, :collection => {"User"=>"user"}
    end

    f.buttons
  end

  show do |ad|
    attributes_table do
      row :username
      row :role
    end
  end
end
