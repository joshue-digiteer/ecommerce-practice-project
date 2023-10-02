class CreateVariantSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :variant_sizes do |t|
      t.belongs_to :product_variant, null: false, foreign_key: true
      t.integer :size

      t.timestamps
    end
  end
end
