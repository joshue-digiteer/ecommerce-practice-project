class User < ApplicationRecord
    has_many :payments, dependent: :nullify
    has_one :cart
    has_many :wish_lists, dependent: :destroy
    has_many :products, through: :wish_lists

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :contact_no, presence: true, numericality: true, length: { minimum: 10, maximum: 15}
    validates :address, presence: true

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable, :validatable, :rememberable

    enum :role, { 'admin': 0, 'customer': 1 }

    # Checks if user is an admin or not based on the role
    def is_admin?
        role == 'admin' ? true : false
    end

    # Checks if user has current cart in use
    # Having ordered at least one product creates a current cart
    def has_current_cart?
        cart != nil
    end
end
