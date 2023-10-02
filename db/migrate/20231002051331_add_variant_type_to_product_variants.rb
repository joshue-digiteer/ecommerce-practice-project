class AddVariantTypeToProductVariants < ActiveRecord::Migration[7.0]
  def change
    add_column :product_variants, :variant_type, :integer
  end
end
