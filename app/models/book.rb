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
    Book.select("books.*, avg(rating) AS avg_rating")
      .joins(:reviews)
      .group(:book_id, :id)
      .order("avg_rating #{direction}")
  end
end
