class AddPhotoToBusinesses < ActiveRecord::Migration
  def up
    add_column :businesses, :photo, :string
  end

  def down
    remove_column :businesses, :photo
  end
end
