ActiveAdmin.register Review do
  filter :created_at

  index do
    column :title
    column :reviewable, :sortable => false
    column :reviewable_type
    column "Approved?" do |r|
      r.approved
    end
    default_actions
  end


  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :text
      f.input :approved, :as => :boolean
      f.input :reported, :as => :boolean
    end

    f.buttons
  end

  show do |ad|
    attributes_table do
      row :title
      row :reviewable_type
      row :user
      row :text
    end
  end
end