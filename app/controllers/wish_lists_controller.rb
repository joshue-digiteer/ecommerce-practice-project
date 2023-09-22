class WishListsController < ApplicationController
    before_action :authenticate_user!

    def index
        # Get all wish lists of user (customer)
        @pagy, @wish_lists = pagy(WishList.where(user_id: current_user.id))
    end

    def create
        # Get product and user
        @product = Product.find(params[:product_id])
        @user = User.find(current_user.id)

        # Create wish list
        @wish_list = WishList.create(user_id: @user.id, product_id: @product.id)
        
        redirect_to product_path(@product)
    end

    def destroy
        @wish_list = WishList.find(params[:id])
        @wish_list.destroy

        redirect_back fallback_location: root_path
    end
end
