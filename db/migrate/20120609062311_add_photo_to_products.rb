class AddPhotoToProducts < ActiveRecord::Migration
  def up
    add_column :products, :photo, :string
  end

  def down
    remove_column :products, :photo
  end
end