class CreateWishLists < ActiveRecord::Migration[7.0]
  def change
    create_table :wish_lists do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
