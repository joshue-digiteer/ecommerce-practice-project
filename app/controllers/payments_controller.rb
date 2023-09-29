class PaymentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # If user is an admin, show all payments of each user
    if current_user.is_admin?
      @pagy, @payments = pagy(Payment.all.order(:created_at))
    else
      # else, show only payments of user
      @pagy, @payments = pagy(Payment.where(user_id: current_user.id).all.order(:created_at))
    end
  end

  def new
    @payment = Payment.new

    # Get cart of customer
    @cart = Cart.where(user_id: current_user.id, is_current: true).first
  end

  def create
    @payment = Payment.new(payment_params)
    @cart = Cart.where(user_id: current_user.id, is_current: true).first
    @payment.user = current_user
    @payment.cart = @cart

    if @payment.save
      # Update cart and each ordered product quantities
      @cart.orders.each do |order|
        # Update product quantity based on quantity ordered
        product = Product.find(order.product_id)
        product.quantity -= order.quantity

        # Remove product from wish list if wish listed by customer
        @wish_list = WishList.where(user_id: current_user.id, product_id: product.id).first
        if not @wish_list.nil?
          @wish_list.destroy
        end

        # Update product
        product.save
      end

      # User is done with using the cart
      @cart.is_current = false
      @cart.save
      
      flash[:notice] = "Order paid successfully. Thank you for shopping!"

      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    redirect_to payments_path
  end

  private
    def payment_params
      params.require(:payment).permit(:shipping_address)
    end
end
