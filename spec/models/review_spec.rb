require 'rails_helper'
describe Review, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:book_id) }
  end
  describe 'Relationship' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end

  describe 'Methods' do
    it 'can find all reviews belonging to a specific user' do
      author_1 = Author.create(name: 'George Orwell')
      book_1 = Book.create(title: '1984', pages: 300, year: 1936)
      user_1 = User.create(username: "Isaac F.")
      review_1 = Review.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 5)
      review_2 = Review.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 4)

      review_1.user_id = user_1.id
      review_1.book_id = book_1.id
      review_2.user_id = user_1.id
      review_2.book_id = book_1.id
      author_1.books << book_1
      book_1.reviews << review_1
      book_1.reviews << review_2

      reviews = Review.find_reviews_by_user_id(user_1.id)
      expect(reviews.first.title).to eq('Great book!')
      expect(reviews.first.body).to eq('I really liked this book! Must read!')
      expect(reviews.second.title).to eq('Pretty good.')
      expect(reviews.second.body).to eq("I enjoyed this book but it has it's issues.")
    end
  end
end
