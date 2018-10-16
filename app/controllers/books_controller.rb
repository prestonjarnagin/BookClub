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
    @top_reviews = @book.most_extreme_reviews(3, "DESC")
    @bottom_reviews = @book.most_extreme_reviews(3, "ASC")
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create_book(book_params)
    redirect_to book_path(@book)
  end

  def destroy
    #TODO Move into model?
    BookAuthor.where(book_id: params[:id]).destroy_all
    Review.where(book_id: params[:id]).destroy_all
    Book.destroy(params[:id])

    redirect_to books_path
  end
end



private

def book_params
  params.require(:book).permit(:title, :pages, :year, :authors)
end
