require 'rails_helper'
describe User, type: :model do
  before :each do

    # Author Setup
    author_1 = Author.create(name: "J.D. Salinger")

    # User Setup
    user_1 = User.create(username: "Isaac F.")
    user_2 = User.create(username: "Preston J.")

    # First Book

    book_1 = author_1.books.create(title: "It's okay", pages: 200, year: 1940)

    book_1.reviews.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 2,
                user_id: user_1.id)
    book_1.reviews.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 3,
                user_id: user_2.id)

    # Second Book

    book_2 = author_1.books.create(title: "Poop Book", pages: 50, year: 1940)
    book_2.reviews.create(
                title: "Terrible",
                body: "I didn't like this book",
                rating: 1,
                user_id: user_2.id)

    # Third Book
    book_3 = author_1.books.create(title: "Catcher in the Rye", pages: 600, year: 1940)
    book_3.reviews.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 5,
                user_id: user_1.id)
    book_3.reviews.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 5,
                user_id: user_2.id)
    book_3.reviews.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 5,
                user_id: user_2.id)

    # Forth Book
    @book_4 = author_1.books.create(title: "Meh", pages: 200, year: 1940)
    @book_4.reviews.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 4,
                user_id: user_1.id)
    @book_4.reviews.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 2,
                user_id: user_2.id)
  end
  describe 'Validations' do
    it { should validate_presence_of(:username) }
  end
  describe 'Relationship' do
    it { should have_many(:reviews) }
  end
  describe 'Methods' do
    it 'should be able to find the users with the most and least reviews' do
      expect(User.sorted_by_reviews_count_limited_to(2, "DESC").first.username).to eq("Preston J.")
      expect(User.sorted_by_reviews_count_limited_to(2, "DESC").last.username).to eq("Isaac F.")
      expect(User.sorted_by_reviews_count_limited_to(2, "ASC").first.username).to eq("Isaac F.")
      expect(User.sorted_by_reviews_count_limited_to(2, "ASC").last.username).to eq("Preston J.")
    end
  end
end
