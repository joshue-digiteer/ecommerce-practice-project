class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true

  # Calculates price based on price of product and quantity ordered
  def total_price
    return quantity * product.price
  end
end
