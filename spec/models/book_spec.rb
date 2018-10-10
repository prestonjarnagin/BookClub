require 'rails_helper'
describe Book, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:pages) }
  end
  describe 'Relationship' do
    it { should have_many(:book_authors) }
    it { should have_many(:authors).through(:book_authors) }
    it { should have_many(:reviews) }
  end
  describe 'Methods' do
    it 'should be able to calculate average review for a book' do
      author_1 = Author.create(name: "J.D. Salinger")

      book_1 = Book.create(title: "It's okay",
                           pages: 200, year: 1940)
      user_1 = User.create(username: "Isaac F.")
      user_2 = User.create(username: "Preston J.")
      review_1 = Review.create(
                  title: "Pretty good.",
                  body: "I enjoyed this book but it has it's issues.",
                  rating: 2)
      review_2 = Review.create(
                  title: "Great book!",
                  body: "I really liked this book! Must read!",
                  rating: 3)
      review_1.user_id = user_1.id
      review_1.book_id = book_1.id
      review_2.user_id = user_2.id
      review_2.book_id = book_1.id
      author_1.books << book_1
      book_1.reviews << review_1
      book_1.reviews << review_2

      book_1 = Book.create(title: "Poop Book",
                           pages: 200, year: 1940)
      user_1 = User.create(username: "Isaac F.")
      user_2 = User.create(username: "Preston J.")
      review_1 = Review.create(
                  title: "Pretty good.",
                  body: "I enjoyed this book but it has it's issues.",
                  rating: 1)
      review_2 = Review.create(
                  title: "Great book!",
                  body: "I really liked this book! Must read!",
                  rating: 1)
      review_1.user_id = user_1.id
      review_1.book_id = book_1.id
      review_2.user_id = user_2.id
      review_2.book_id = book_1.id
      author_1.books << book_1
      book_1.reviews << review_1
      book_1.reviews << review_2

      book_1 = Book.create(title: "Catcher in the Rye",
                           pages: 200, year: 1940)
      user_1 = User.create(username: "Isaac F.")
      user_2 = User.create(username: "Preston J.")
      review_1 = Review.create(
                  title: "Pretty good.",
                  body: "I enjoyed this book but it has it's issues.",
                  rating: 4)
      review_2 = Review.create(
                  title: "Great book!",
                  body: "I really liked this book! Must read!",
                  rating: 5)
      review_1.user_id = user_1.id
      review_1.book_id = book_1.id
      review_2.user_id = user_2.id
      review_2.book_id = book_1.id
      author_1.books << book_1
      book_1.reviews << review_1
      book_1.reviews << review_2

      book_1 = Book.create(title: "Meh",
                           pages: 200, year: 1940)
      user_1 = User.create(username: "Isaac F.")
      user_2 = User.create(username: "Preston J.")
      review_1 = Review.create(
                  title: "Pretty good.",
                  body: "I enjoyed this book but it has it's issues.",
                  rating: 3)
      review_2 = Review.create(
                  title: "Great book!",
                  body: "I really liked this book! Must read!",
                  rating: 3)
      review_1.user_id = user_1.id
      review_1.book_id = book_1.id
      review_2.user_id = user_2.id
      review_2.book_id = book_1.id
      author_1.books << book_1
      book_1.reviews << review_1
      book_1.reviews << review_2

      expect(book_1.average_rating).to eq(3)
      expect(Book.sorted_by_reviews_ascending.first.title).to eq("Poop Book")
      expect(Book.sorted_by_reviews_descending.first.title).to eq("Catcher in the Rye")
    end
  end
end
