ActiveAdmin.register Product do

  controller.authorize_resource
  actions :all, :except => :destroy,  :if => proc {current_admin_user.cannot? :destroy, product}

  filter :name

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