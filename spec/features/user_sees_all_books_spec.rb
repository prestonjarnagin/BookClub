require 'rails_helper'

describe 'book index' do
  it "book can see basic book info" do
    author_1 = Author.create(name: 'George Orwell')
    book_1 = Book.create(title: '1984', pages: 300, year: 1936)

    author_1.books << book_1

    author_2 = Author.create(name: 'Aldous Huxley')
    book_2 = Book.create(title: 'Brave New World', pages: 290, year: 1968)

    author_2.books << book_2

    visit books_path

    expect(page).to have_content('1984')
    expect(page).to have_content('300')
    expect(page).to have_content('1936')
    expect(page).to have_content('George Orwell')

    expect(page).to have_content('Brave New World')
    expect(page).to have_content('290')
    expect(page).to have_content('1968')
    expect(page).to have_content('Aldous Huxley')
  end

  it "user can see overall review for books" do
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

    visit books_path

    expect(page).to have_content('4.5')
    expect(page).to have_content('2')
  end

  it "user can navigate to sorted pages" do
    visit books_path
    click_on("best_rated")
    expect(page).to have_current_path("/books?sorting=rating&direction=ASC")
    click_on("worst_rated")
    expect(page).to have_current_path("/books?sorting=rating&direction=DESC")
    click_on("most_pages")
    expect(page).to have_current_path("/books?sorting=pages&direction=ASC")
    click_on("least_pages")
    expect(page).to have_current_path("/books?sorting=pages&direction=DESC")
    click_on("most_reviews")
    expect(page).to have_current_path("/books?sorting=reviews&direction=ASC")
    click_on("least_reviews")
    expect(page).to have_current_path("/books?sorting=reviews&direction=DESC")

    # expect(all(".book")[0]) this is how you test that your books are in order
  end

  it 'user can navigate to books through links' do
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

    visit books_path

    within '.books_list' do
      click_link '1984'
      expect(page).to have_current_path("/books/#{book_1.id}")
      expect(page).to have_content("1984")
      expect(page).to have_content("300")
    end

    visit books_path
    within ".top_books" do
      click_link '1984'
    end
      expect(page).to have_current_path("/books/#{book_1.id}")
      expect(page).to have_content("1984")
      expect(page).to have_content("300")

    visit books_path
    within ".bottom_books" do
      click_link '1984'
    end
      expect(page).to have_current_path("/books/#{book_1.id}")
      expect(page).to have_content("1984")
      expect(page).to have_content("300")
  end
end
