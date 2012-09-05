class Add2ScaleToPrice < ActiveRecord::Migration
  def change
    change_column :products, :price, :decimal, {:precision => 10, :scale => 2}
  end
end
