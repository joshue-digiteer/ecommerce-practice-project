class ProductsController < ApplicationController
  # To not allow non-authenticated users to access both routes and actions for this resource
  before_action :authenticate_user!

  def index
    @pagy, @products = pagy(Product.where("name LIKE ?", "%#{params[:filter]}%").all.order(:name))

    # If user is a customer, get cart
    if not current_user.is_admin?
      @cart = Cart.where(user_id: current_user.id, is_current: true).first

      # If no current cart used by customer
      if @cart.nil?
        # Create new cart for customer
        @cart = Cart.create(user_id: current_user.id)
      end
    end
  end

  def show
    @product = Product.find(params[:id])

    # Check if user is a customer
    if not current_user.is_admin?
      # Get customer's cart
      @cart = Cart.where(user_id: current_user.id, is_current: true).first

      # Get user's order of the product
      # nil if no order yet
      @order = Order.where(cart_id: @cart.id, product_id: @product.id).first
      
      # Get customer's review for the product if it exists
      # nil if customer has no review for the product
      @user_review = Review.where(user_id: current_user.id, product_id: @product.id).first

      # Check if customer wishlisted the product
      # nil if not wishlisted by customer
      @wish_list = WishList.where(user_id: current_user.id, product_id: @product.id).first
    end

    # Paginate reviews if there are existing reviews for the product
    if @product.reviews.present?
      @pagy_reviews, @reviews = current_user.is_admin? ? pagy(@product.reviews) : pagy(@product.reviews.excluding(@user_review))
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      # redirect_to is used after a successful database edit in order to cause the browser to make a new request
      # Otherwise, if the user refreshes the page, the browser will make the same request, and the mutation will be repeated
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, status: :see_other
  end
  
  private
    def product_params
      params.require(:product).permit(:name, :description, :quantity, :price)
    end
end
