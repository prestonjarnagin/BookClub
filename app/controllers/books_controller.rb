class BooksController < ApplicationController
  def index
    # binding.pry
    if params[:sorting] == "rating"
      @books = Book.sorted_by_reviews(params[:direction])
    elsif params[:sorting] == "pages"
      @books = Book.sorted_by_pages(params[:direction])
    elsif params[:sorting] == "reviews"
      @books = Book.sorted_by_reviews_count(params[:direction])
    else
      @books = Book.all
    end
  end
end
