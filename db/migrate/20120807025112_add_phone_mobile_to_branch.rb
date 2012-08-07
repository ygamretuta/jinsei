class AddPhoneMobileToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :mobile, :string
    add_column :branches, :phone, :string
  end
end