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

	# Product variant (part of nested forms)
	has_many :product_variants, dependent: :destroy
	accepts_nested_attributes_for :product_variants, allow_destroy: true, reject_if: proc { |attrs| (attrs['name'].blank? || attrs['quantity'].blank?) }
	# accepts_nested_attributes_for :product_variants, reject_if: ->(attr){ attr['name'].blank? }, allow_destroy: true
end
