class AddCallForPricingToProduct < ActiveRecord::Migration
  def change
    add_column :products, :call_for_pricing, :boolean, {:default => false}
  end
end