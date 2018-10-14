class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def average_rating
    reviews.average(:rating).to_f
  end

  def self.sorted_by_reviews(direction)
    select("books.*, avg(rating) AS avg_rating")
      .joins(:reviews)
      .group(:book_id, :id)
      .order("avg_rating #{direction}")
  end

  def self.sorted_by_pages(direction)
    order("pages #{direction}")
  end

  def self.sorted_by_reviews_count(direction)
    books = select("books.*, count(reviews.id) AS total_reviews")
      .joins(:reviews)
      .group(:book_id, :id)
      .order("total_reviews #{direction}")
  end

  def self.sorted_by_reviews_limited_to(count, direction)
    sorted_by_reviews(direction).limit(count)
  end

  def self.create_book(params)
    if Book.find_by(title: params[:title]) == nil && Author.find_by(name: params[:authors]) == nil
      author = Author.create(name: params[:authors])
      book = author.books.create(title: params[:title], pages: params[:pages], year: params[:year])
    elsif Book.find_by(title: params[:title]) && Author.find_by(name: params[:authors]) == nil
      author = Author.create(name: params[:authors])
      book = Book.find_by(title: params[:title])
      author.books << book
    elsif Book.find_by(title: params[:title]) == nil && Author.find_by(name: params[:authors])
      author = Author.find_by(name: params[:authors])
      book = author.books.create(title: params[:title], pages: params[:pages], year: params[:year])
    else
      book = Book.find_by(title: params[:title])
      Author.find_by(name: params[:authors]).books << book
    end
    book
  end

  def self.find_reviews_by_book(book_id)
    select("books.*, users.username AS username").joins(:user).where(book_id: book_id)
  end
end
