require 'rails_helper'

describe 'book index' do
  it "book can see basic book info" do
    author_1 = Author.create(name: 'George Orwell')
    book_1 = Book.create(title: '1984', pages: 300, year: 1936)

    author_1.books << book_1

    author_2 = Author.create(name: 'Aldous Huxley')
    book_2 = Book.create(title: 'Brave New World', pages: 290, year: 1968)

    author_2.books << book_2

    visit '/books'

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

    visit '/books'

    expect(page).to have_content('4.5')
    expect(page).to have_content('2')
  end

  it "user can navigate to sorted pages" do
    visit '/books'
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
end

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

    visit '/books'

    expect(page).to have_content("Catcher in the Rye, Meh, It's okay")
    expect(page).to have_content("Poop Book, It's okay, Meh")
    expect(page).to have_content("Isaac F., Preston J.,")
  end
  it 'user can create new book' do
    visit '/books'

    click_button "New book"
    expect(current_path).to eq("/books/new")

    expect(page).to have_content("New Book")
    fill_in 'Title', with: "Good book"
    fill_in 'Pages', with: "567"
    fill_in 'Year', with: "1987"
    fill_in 'Author', with: "Jimmy"

    click_button "Create Book"

    # expect(current_path).to eq("/books/1")
    expect(page).to have_content("Good book")
    expect(page).to have_content("Jimmy")

  end
end
