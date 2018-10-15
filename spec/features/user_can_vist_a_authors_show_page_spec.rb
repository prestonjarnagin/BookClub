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
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 5,
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
                body: "I enjoyed this book but it has it's issues.",
                rating: 5,
                user_id: user_1.id)
    book_3.reviews.create(
                title: "Great book!",
                body: "I really liked this book! Must read!",
                rating: 2,
                user_id: user_2.id)

    visit '/authors/1'

    expect(page).to have_content("George Orwell")
    expect(page).to have_content("1984")
    expect(page).to have_content("Animal Farm")
    expect(page).to have_content("Homage to Catalonia")
    expect(page).to have_content("345")
    expect(page).to have_content("I'd read it again!")
    expect(page).to have_content("it has it's issues.")
    expect(page).to have_content("Must read!")

  end
end
