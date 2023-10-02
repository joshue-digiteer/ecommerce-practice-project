class ProductVariant < ApplicationRecord
  belongs_to :product

  # Variant color
  has_many :variant_colors, dependent: :destroy
  accepts_nested_attributes_for :variant_colors, allow_destroy: true

  # Variant size
  has_many :variant_sizes, dependent: :destroy
  accepts_nested_attributes_for :variant_sizes, allow_destroy: true

  validates :name, presence: true
  validates :quantity, presence: true
  validates :variant_type, presence: true

  enum variant_type: { color_variant: 0, size_variant: 1 }

  def self.variant_type_select
    variant_types.keys.map { |k| [k.titleize, k] }
  end
end
