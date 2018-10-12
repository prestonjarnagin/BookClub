class BooksController < ApplicationController
  def index
    if params[:sorting] == "rating"
      @books = Book.sorted_by_reviews(params[:direction])
    elsif params[:sorting] == "pages"
      @books = Book.sorted_by_pages(params[:direction])
    elsif params[:sorting] == "reviews"
      @books = Book.sorted_by_reviews_count(params[:direction])
    else
      @books = Book.all
    end
    @top_books = Book.sorted_by_reviews_limited_to(3, "DESC")
    @bottom_books = Book.sorted_by_reviews_limited_to(3, "ASC")
    @top_users = User.sorted_by_reviews_count_limited_to(3, "DESC")
    @bottom_users = User.sorted_by_reviews_count_limited_to(3, "ASC")
  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.find_reviews_by_book(params[:id])
  end
end
