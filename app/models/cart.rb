class Cart < ApplicationRecord
    has_many :orders, dependent: :destroy
    has_many :products, through: :orders
    has_one :payment, dependent: :destroy
    belongs_to :user

    # Calculates total price based on orders
    def total_price
        total_price = 0
        orders.each do |order|
            total_price += order.total_price
        end
        return total_price
    end
end
