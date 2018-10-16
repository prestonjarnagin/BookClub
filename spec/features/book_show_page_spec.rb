require 'rails_helper'

describe 'book show page' do
  it "user can navigate to book show page" do
    author_1 = Author.create(name: 'George Orwell')
    book_1 = Book.create(title: '1984', pages: 300, year: 1936)
    user_1 = User.create(username: "Isaac F.")
    user_2 = User.create(username: "Preston J.")
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
    review_2.user_id = user_2.id
    review_2.book_id = book_1.id
    author_1.books << book_1
    book_1.reviews << review_1
    book_1.reviews << review_2

    visit "/books/#{book_1.id}"
    expect(page).to have_content('1984')
    expect(page).to have_content('300')
    expect(page).to have_content('1936')
  end

  it "user can see book reviews" do
    author_1 = Author.create(name: 'George Orwell')
    book_1 = Book.create(title: '1984', pages: 300, year: 1936)
    user_1 = User.create(username: "Isaac F.")
    user_2 = User.create(username: "Preston J.")
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
    review_2.user_id = user_2.id
    review_2.book_id = book_1.id
    author_1.books << book_1
    book_1.reviews << review_1
    book_1.reviews << review_2

    visit "/books/#{book_1.id}"

    expect(page).to have_content('Great book!')
    expect(page).to have_content('Pretty good.')
    expect(page).to have_content('Isaac F.')
    expect(page).to have_content('Preston J.')
    expect(page).to have_content('5')
    expect(page).to have_content("I enjoyed this book but it has it's issues.")
  end

  it 'user can see stats for all books' do

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

    visit books_path

    expect(page).to have_content("-Catcher in the Rye- -Meh- -It's okay-")
    expect(page).to have_content("-Poop Book- -It's okay- -Meh-")
    expect(page).to have_content("-Isaac F.- -Preston J.-")
  end

  it 'shows stats' do
    # Author Setup
    author_1 = Author.create(name: "J.D. Salinger")

    # User Setup
    user_1 = User.create(username: "Isaac F.")
    user_2 = User.create(username: "Preston J.")

    # First Book

    book_1 = author_1.books.create(title: "It's okay", pages: 200, year: 1940)

    book_1.reviews.create(
                title: "Three!",
                body: "I enjoyed this book but it has it's issues.",
                rating: 3,
                user_id: user_1.id)
    book_1.reviews.create(
                title: "One! :(",
                body: "I really liked this book! Must read!",
                rating: 1,
                user_id: user_2.id)
    book_1.reviews.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 5,
                user_id: user_2.id)
    book_1.reviews.create(
                title: "I hate it",
                body: "I really liked this book! Must read!",
                rating: 1,
                user_id: user_2.id)
    book_1.reviews.create(
                title: "Fantastic",
                body: "I really liked this book! Must read!",
                rating: 4,
                user_id: user_2.id)
    book_1.reviews.create(
                title: "Horrible",
                body: "I really liked this book! Must read!",
                rating: 1,
                user_id: user_2.id)
    book_1.reviews.create(
                title: "Whooooo",
                body: "I really liked this book! Must read!",
                rating: 5,
                user_id: user_2.id)

    visit book_path(book_1)


    within '.positive_reviews' do
      expect(page).to have_content('Great book!')
      expect(page).to have_content('Fantastic')
      expect(page).to have_content('Whooooo')
      expect(page).to_not have_content('One! :(')
    end

    within '.negative_reviews' do
      expect(page).to have_content('One! :(')
      expect(page).to have_content('I hate it')
      expect(page).to have_content('Horrible')
      expect(page).to_not have_content('Whooooo')
    end

    expect(page).to have_content('2.85')
  end

  it "new user can leave a review" do
    author_1 = Author.create(name: 'George Orwell')
    book_1 = Book.create(title: '1984', pages: 300, year: 1936)

    visit book_path(book_1)
    click_on 'New Review'
  end
end
