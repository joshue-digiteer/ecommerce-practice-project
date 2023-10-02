class VariantSize < ApplicationRecord
  belongs_to :product_variant

  validates :size, presence: true
end
