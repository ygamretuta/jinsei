ActiveAdmin.register Product do
  controller do
    authorize_resource
    include ActiveAdminCanCan
  end

  filter :name

  active_admin_allowed_action_items

  index do
    column :name
    default_actions
  end

  form :partial => "form"

  show do |ad|
    attributes_table do
      row :name
      row :category
      row :catalog
    end
  end
end