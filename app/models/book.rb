class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :pages
  validates_presence_of :year
  has_many :authors
end
