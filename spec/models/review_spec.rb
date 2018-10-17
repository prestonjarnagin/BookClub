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
      book_1 = author_1.books.create(title: '1984', pages: 300, year: 1936)
      user_1 = User.create(username: "Isaac F.")
      review_1 = book_1.reviews.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 5,
                user_id: user_1.id)
      review_2 = book_1.reviews.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 4,
                user_id: user_1.id)


      reviews = Review.find_reviews_by_user_id(user_1.id)
      expect(reviews.first.title).to eq('Pretty good.')
      expect(reviews.second.title).to eq('Great book!')
    end
  end
end
