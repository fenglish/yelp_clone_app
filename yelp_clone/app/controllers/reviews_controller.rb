class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    review = @restaurant.reviews.build_with_user(review_params, @user)

    if review.save
      redirect_to restaurants_path
    else
      if review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @review = @restaurant.reviews.find(params[:format])
    @review.destroy
    flash[:notice] = 'Review deleted successfully'
    redirect_to '/restaurants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
