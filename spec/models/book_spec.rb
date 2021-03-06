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
                user_id: user_1.id)

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

  describe 'Methods' do
    it 'should be able to calculate average rating for a book' do
      expect(@book_4.average_rating).to eq(3)
    end
    it 'should be able to sort books by ratings' do
      expect(Book.sorted_by_reviews("ASC").first.title).to eq("Poop Book")
      expect(Book.sorted_by_reviews("DESC").first.title).to eq("Catcher in the Rye")
    end
    it 'should be able to sort books by pages' do
      expect(Book.sorted_by_pages("ASC").first.title).to eq("Poop Book")
      expect(Book.sorted_by_pages("DESC").first.title).to eq("Catcher in the Rye")
    end
    it 'should be able to sort by number of reviews' do
      expect(Book.sorted_by_reviews_count("ASC").first.title).to eq("Poop Book")
      expect(Book.sorted_by_reviews_count("DESC").first.title).to eq("Catcher in the Rye")
    end
    it 'should be able to find top and bottom reviews' do
      expect(Book.sorted_by_reviews_limited_to(3, "DESC").first.title).to eq("Catcher in the Rye")
      expect(Book.sorted_by_reviews_limited_to(3, "DESC").last.title).to eq("It's okay")
      expect(Book.sorted_by_reviews_limited_to(3, "ASC").first.title).to eq("Poop Book")
      expect(Book.sorted_by_reviews_limited_to(3, "ASC").last.title).to eq("Meh")
    end
    it 'should be able to create a book and author if they dont already exist' do
      params = {title: "Catcher in the Rye", pages: 600, year: 1940, authors:"J.D. Salinger"}
      Book.create_book(params)
      expect(Book.all.count).to eq(4)
      expect(Author.all.count).to eq(1)

      params = {title: "Catcher in the Rye", pages: 600, year: 1940, authors:"J.K. Rowling"}
      Book.create_book(params)
      expect(Book.all.count).to eq(4)
      expect(Author.all.count).to eq(2)
      expect(Author.all.last.books.count).to eq(1)

      params = {title: "Harry Potter", pages: 600, year: 1940, authors:"J.K. Rowling"}
      Book.create_book(params)
      expect(Book.all.count).to eq(5)
      expect(Author.all.count).to eq(2)
      expect(Author.all.last.books.count).to eq(2)

      params = {title: "A Song of Ice and Fire", pages: 600, year: 1940, authors:"George R.R. Martin"}
      Book.create_book(params)
      expect(Book.all.count).to eq(6)
      expect(Author.all.count).to eq(3)
      expect(Author.all.last.books.count).to eq(1)
    end

    it "can find most extreme reviews" do
      result = @book_4.most_extreme_reviews(1, 'DESC')
      expect(result.first.title).to eq('Pretty good.')
    end
  end
end
