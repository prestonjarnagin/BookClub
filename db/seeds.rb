# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
def prepare
  title = Faker::Book.title
  pages = Faker::Number.between(100,1000)
  year = Faker::Number.between(1800,2018)
  hash = {title: title, pages: pages, year: year}
end

def review_book(book)
  title = Faker::Hipster.sentence(4)
  body = Faker::Hipster.paragraph(2)
  rating = Faker::Number.between(0,6)
  new_review = Review.create(title: title, body: body, rating: rating)
  new_review.user_id = create_user.id
  book.reviews << new_review
end

def create_user
  name = Faker::Internet.username
  user = User.create(username: name)
end

10.times do
  author_name = Faker::Book.author

  author_1 = Author.create(name: author_name)
  book_1 = Book.create(prepare)

  book_2 = Book.create(prepare)

  book_3 = Book.create(prepare)

  author_1.books << book_1
  author_1.books << book_2
  author_1.books << book_3

  review_book(book_1)
  review_book(book_1)
  review_book(book_1)

  review_book(book_2)
  review_book(book_2)
  review_book(book_2)

  review_book(book_3)
  review_book(book_3)
  review_book(book_3)

  user = create_user

  title = Faker::Hipster.sentence(4)
  body = Faker::Hipster.paragraph(2)
  rating = Faker::Number.between(0,6)
  new_review = Review.create(title: title, body: body, rating: rating)
  new_review.user_id = user.id
  book_3.reviews << new_review

  title = Faker::Hipster.sentence(4)
  body = Faker::Hipster.paragraph(2)
  rating = Faker::Number.between(0,6)
  new_review = Review.create(title: title, body: body, rating: rating)
  new_review.user_id = user.id
  book_2.reviews << new_review
end

2.times do
  author_name_1 = Faker::Book.author
  author_name_2 = Faker::Book.author

  author_1 = Author.create(name: author_name_1)
  author_2 = Author.create(name: author_name_2)

  book_1 = Book.create(prepare)

  review_book(book_1)
  review_book(book_1)
  review_book(book_1)

  author_1.books << book_1
  author_2.books << book_1
end
