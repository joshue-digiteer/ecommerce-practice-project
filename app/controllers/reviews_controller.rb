class ReviewsController < ApplicationController
    before_action :authenticate_user!

    def create
        # Get product and user
        @product = Product.find(params[:product_id])
        @user = User.find(current_user.id)

        # Create review
        @review = Review.new(score: params[:score], comment: params[:comment], user_id: @user.id, product_id: @product.id)

        if @review.save
            redirect_to product_path(@product)
        else
            render "products/show", status: :unprocessable_entity
        end
    end

    # For admin reply update only
    def update
        # Get product
        @product = Product.find(params[:product_id])

        # Get review
        @review = Review.find(params[:id])

        # Add admin reply to review
        @review.admin_reply = params[:admin_reply]

        # Update review
        @review.save

        redirect_to product_path(@product)
    end

    def destroy
        @review = Review.find(params[:id])
        @review.destroy

        redirect_to product_path(@product)
    end
end
