class AddCurrencyToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :currency, :string, {:maxlength => 3, :default => "PHP"}
  end
end
