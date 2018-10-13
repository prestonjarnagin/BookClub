class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.create_review(review_params)
    redirect_to review_path(@review)
  end
end

private

def review_params
  params.require(:review).permit(:title, :user, :rating, :body)
end
