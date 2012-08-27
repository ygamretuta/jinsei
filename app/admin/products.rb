ActiveAdmin.register Product do
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