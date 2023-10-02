class VariantColor < ApplicationRecord
  belongs_to :product_variant

  validates :name, presence: true
end
