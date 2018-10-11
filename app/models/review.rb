class Review < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :rating
  validates_presence_of :user_id
  validates_presence_of :book_id

  belongs_to :user
  belongs_to :book

  def self.find_reviews_by_book(book_id)
    select("reviews.*, users.username AS username").joins(:user).where(book_id: book_id)
  end
end
