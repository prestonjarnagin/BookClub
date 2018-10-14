require 'rails_helper'

describe 'basic user show page' do
  it 'shows basic information about the user' do
    user_1 = User.create(username: "Isaac F.")
    visit "/users/#{user_1.id}"
    expect(page).to have_content('Isaac F.')
  end

  it 'shows all reviews for the current user' do
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

    visit "/users/#{user_1.id}"

    expect(page).to have_content('Great book!')
    expect(page).to have_content('I really liked this book! Must read!')
    expect(page).to have_content('Pretty good.')
    expect(page).to have_content("I enjoyed this book but it has it's issues.")
  end

  it 'shows reviews from multiple books' do
    author_1 = Author.create(name: 'George Orwell')
    book_1 = Book.create(title: '1984', pages: 300, year: 1936)
    book_2 = Book.create(title: 'Brave New World', pages: 200, year: 1940)
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
    book_2.reviews << review_2

    visit "/users/#{user_1.id}"

    expect(page).to have_content('Great book!')
    expect(page).to have_content('I really liked this book! Must read!')
    expect(page).to have_content('Pretty good.')
    expect(page).to have_content("I enjoyed this book but it has it's issues.")
  end

  it 'shows information about the books' do
    author_1 = Author.create(name: 'George Orwell')
    author_2 = Author.create(name: 'Aldous Huxley')

    book_1 = Book.create(title: '1984', pages: 300, year: 1936)
    book_2 = Book.create(title: 'Brave New World', pages: 200, year: 1932)

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
    author_2.books << book_2
    book_1.reviews << review_1
    book_2.reviews << review_2

    visit "/users/#{user_1.id}"

    expect(page).to have_content('1984')
    expect(page).to have_content('Brave New World')
  end
end

describe 'user show page sorting' do
  it 'sorts reviews by most recent' do
    author_1 = Author.create(name: 'George Orwell')
    author_2 = Author.create(name: 'Aldous Huxley')

    book_1 = author.books.create(title: '1984', pages: 300, year: 1936)
    book_2 = author_2.books.create(title: 'Brave New World', pages: 200, year: 1932)

    user_1 = User.create(username: "Isaac F.")
    review_1 = Review.create(
              title: "First Recent Review",
              body: "I really liked this book! Must read!",
              rating: 5)
    review_2 = Review.create(
              title: "Second Recent Review",
              body: "I enjoyed this book but it has it's issues.",
              rating: 4)
    review_3 = Review.create(
              title: "Third Recent Review",
              body: "I enjoyed this book but it has it's issues.",
              rating: 4)
    sleep(1.seconds)
    review_4 = Review.create(
              title: "Old Review",
              body: "I enjoyed this book but it has it's issues.",
              rating: 2)
    book_1.reviews << review_1
    book_1.reviews << review_2
    book_2.reviews << review_3
    book_1.reviews << review_4

    visit "/users/#{user_1.id}"

    expect
  end

  it 'sorts reviews by least recent' do

  end
end
