class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :cart, null: false, foreign_key: true
      t.string :shipping_address, null: false

      t.timestamps
    end
  end
end
