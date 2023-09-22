class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @cart = Cart.find(params[:id])

    # Get payment details
    @payment = Payment.where(cart_id: @cart.id).first
    
    # Get user details
    @user = User.find(@payment.user_id)
  end
end
