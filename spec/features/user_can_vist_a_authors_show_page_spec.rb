require 'rails_helper'

describe 'Author show page' do
  it 'user can see basic author info' do

    author_1 = Author.create(name: 'George Orwell')
    user_1 = User.create(username: "Isaac F.")
    user_2 = User.create(username: "Preston J.")
    book_1 = author_1.books.create(title: '1984', pages: 300, year: 1948)
    book_2 = author_1.books.create(title: 'Animal Farm', pages: 345, year: 1940)
    book_3 = author_1.books.create(title: 'Homage to Catalonia', pages: 456, year: 1950)

    book_1.reviews.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 2,
                user_id: user_1.id)
    book_1.reviews.create(
                title: "It's aight",
                body: "Mehhhhhh",
                rating: 3,
                user_id: user_2.id)
    book_2.reviews.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 2,
                user_id: user_1.id)
    book_2.reviews.create(
                title: "Great book!",
                body: "I really liked this book! I'd read it again!",
                rating: 5,
                user_id: user_2.id)
    book_3.reviews.create(
                title: "Pretty good.",
                body: "Hey, that's pretty good!",
                rating: 4,
                user_id: user_1.id)
    book_3.reviews.create(
                title: "Great book!",
                body: "Booooo bad book",
                rating: 1,
                user_id: user_2.id)

    visit author_path(author_1)

    expect(page).to have_content("George Orwell")
    expect(page).to have_content("1984")
    expect(page).to have_content("Animal Farm")
    expect(page).to have_content("Homage to Catalonia")
    expect(page).to have_content("345")
    expect(page).to have_content("Pretty good.")
    expect(page).to have_content("It's aight")
    expect(page).to have_content("Great book!")
  end

  it "can delete an author" do
    author_1 = Author.create(name: 'George Orwell')
    user_1 = User.create(username: "Isaac F.")
    user_2 = User.create(username: "Preston J.")
    book_1 = author_1.books.create(title: '1984', pages: 300, year: 1948)

    book_1.reviews.create(
                title: "Pretty good.",
                body: "I enjoyed this book but it has it's issues.",
                rating: 2,
                user_id: user_1.id)
    book_1.reviews.create(
                title: "It's aight",
                body: "Mehhhhhh",
                rating: 3,
                user_id: user_2.id)

    visit author_path(author_1)
    click_on "Delete"

    expect(current_path).to eq books_path
    expect(page).to_not have_content('George Orwell')
  end
end
