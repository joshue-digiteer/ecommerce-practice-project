class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    # Get product and cart 
    @cart = Cart.where(user_id: current_user.id, is_current: true).first
    @product = Product.find(params[:product_id])

    # Create order
    @order = Order.create(quantity: params[:quantity], product_id: @product.id, cart_id: @cart.id)

    redirect_to products_path
  end

  def update
    @order = Order.find(params[:id])
    @product = Product.find(params[:product_id])

    @order.quantity = params[:quantity]
    @order.save
    
    redirect_to products_path
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_back fallback_location: root_path
  end
end
