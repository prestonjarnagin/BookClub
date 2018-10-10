class Book < ApplicationRecord
  validates_presence_of :title
  # validates_presence_of :author_ids
  validates_presence_of :pages
  validates_presence_of :year
  # belongs_to :author
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews
end
