class Payment < ApplicationRecord
    belongs_to :cart
    belongs_to :user, optional: true

    validates :shipping_address, presence: true
end
