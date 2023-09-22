class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.decimal :total_price, default: 0.0
      t.boolean :is_current, default: true

      t.timestamps
    end
  end
end
