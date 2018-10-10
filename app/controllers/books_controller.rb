class BooksController < ApplicationController
  def index
    # binding.pry
    if params[:sorting] == "rating"
      @books = Book.sorted_by_reviews(params[:direction])
    else
      @books = Book.all
    end
  end
end
