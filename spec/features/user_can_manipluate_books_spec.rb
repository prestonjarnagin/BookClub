require 'rails_helper'

describe 'Creation' do
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

    expect(page).to have_content("Good book")
    expect(page).to have_content("Jimmy")
  end
end

describe 'Deletion' do
  it 'user can delete a book' do
    Book.create(title: "Harry Potter", pages: 543, year: 2005)
    visit '/books/1'


    expect(page).to have_content("Harry Potter")
    click_link 'Delete'

    expect(current_path).to eq("/books")
    expect(page).to_not have_content("Harry Potter")
  end
end
