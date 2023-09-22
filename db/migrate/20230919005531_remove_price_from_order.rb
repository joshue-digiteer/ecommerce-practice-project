class RemovePriceFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :price, :decimal
  end
end
