class CreateVariantColors < ActiveRecord::Migration[7.0]
  def change
    create_table :variant_colors do |t|
      t.belongs_to :product_variant, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
