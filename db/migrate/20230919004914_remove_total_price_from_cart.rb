class RemoveTotalPriceFromCart < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :total_price, :decimal
  end
end
