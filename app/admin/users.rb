ActiveAdmin.register User do
  filter :username

  index do
    column :username
    column :role
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :username
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
