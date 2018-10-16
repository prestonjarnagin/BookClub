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
  year = Faker::Number.between(1918,2018)
  @hash = {title: title, pages: pages, year: year}
end


def review_book(book)
  title = Faker::Hipster.sentence(4)
  body = Faker::Hipster.paragraph(2)
  rating = Faker::Number.between(1,5)
  new_review = book.reviews.create(title: title, body: body, rating: rating, user_id: create_user.id)
end

def create_user
  name = Faker::Internet.username
  user = User.create(username: name)
end

10.times do
  author_name = Faker::Book.author

  author_1 = Author.create(name: author_name)
  book_1 = author_1.books.create(prepare)

  book_2 = author_1.books.create(prepare)

  book_3 = author_1.books.create(prepare)

  12.times do
    review_book(book_1)
  end

  8.times do
    review_book(book_2)
  end

  10.times do
    review_book(book_3)
  end
end

2.times do
  author_name_1 = Faker::Book.author
  author_name_2 = Faker::Book.author

  author_1 = Author.create(name: author_name_1)
  author_2 = Author.create(name: author_name_2)
  prepare
  @hash[:authors] = [author_1, author_2]

  book_1 = Book.create(@hash)

  9.times do
    review_book(book_1)
  end

  3.times do
    user = create_user
    5.times do
      title = Faker::Hipster.sentence(4)
      body = Faker::Hipster.paragraph(2)
      rating = Faker::Number.between(1,5)
      book = Book.create(prepare)
      new_review = book.reviews.create(title: title, body: body, rating: rating, user_id: user.id)
    end
  end

end
