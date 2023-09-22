class Product < ApplicationRecord
    has_many :orders, dependent: :destroy
    has_many :users, through: :orders
    has_many :carts, through: :orders
    has_many :reviews, dependent: :destroy
    has_many :wish_lists, dependent: :destroy
    has_many :users, through: :wish_lists

    validates :name, presence: true
    validates :description, presence: true
    validates :quantity, presence: true
    validates :price, presence: true
end
