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
	# Do not use reject_if if adding error validation messages for display as it will automatically reject and discard nested input then save the parent model instead
	accepts_nested_attributes_for :product_variants, allow_destroy: true
	
	# accepts_nested_attributes_for :product_variants, allow_destroy: true, reject_if: proc { |attrs| (attrs['name'].blank? || attrs['quantity'].blank?) }
	# accepts_nested_attributes_for :product_variants, reject_if: ->(attr){ attr['name'].blank? }, allow_destroy: true

	# Filter
	SORT_OPTIONS = {
		"name_asc" => {name: :asc},
		"name_desc" => {name: :desc},
		"price_asc" => {price: :asc},
		"price_desc" => {price: :desc}
	}

	scope :filter_products, -> (filter_params) {
		products = all

		# Search
		products = products.where("name ILIKE ?", "%#{filter_params[:filter]}%") if filter_params[:filter].present?

		# In stock
		products = products.where("quantity > 0") if filter_params[:stock].present?

		# Sort
		products = products.order(SORT_OPTIONS[filter_params[:sort]]) if filter_params[:sort].present?
	}
end
