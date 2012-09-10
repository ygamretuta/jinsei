ActiveAdmin.register Business do
  filter :name

  controller.authorize_resource

  controller do
    def scoped_collection
      Business.includes(:products, :catalogs)
    end
  end

  index do
    column :name
    default_actions
  end


  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :category, :as => :select, :collection => Category.all
      f.input :address
      f.input :approved, :as => :boolean
      f.input :description
    end

    f.buttons
  end

  show do |ad|
    attributes_table do
      row :name
      row :address
      row :category
    end

    panel "Products" do
      table_for business.products do
        column :name
      end
    end

    panel "Catalog" do
      table_for business.catalogs do
        column :name
      end
    end
  end
end