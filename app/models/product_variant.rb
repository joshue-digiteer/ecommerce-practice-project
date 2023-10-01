class ProductVariant < ApplicationRecord
  belongs_to :product

  validates :name, presence: true
  validates :quantity, presence: true
end
