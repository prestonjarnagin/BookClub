class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    book.reviews.create_review(review_params)

    redirect_to book_path(book)
  end

  def destroy
    @review = Review.destroy(params[:id])
    redirect_to user_path(@review.user)
  end
end

private

def review_params
  params.require(:review).permit(:title, :user, :rating, :body)
end
