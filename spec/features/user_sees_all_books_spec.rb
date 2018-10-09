require 'rails_helper'

describe 'user index' do

  it "user can see all books" do
    Book.create(title: '1984', pages: 300, year: 1964, author: 'George Orwell')
    Book.create(title: 'Brave New World', pages: 290, year: 1968, author: 'Aldous Huxley')
    visit '/books'
    expect(page).to have_content('1984')
    expect(page).to have_content('300')
    expect(page).to have_content('1964')
    expect(page).to have_content('George Orwell')

    expect(page).to have_content('Brave New World')
    expect(page).to have_content('290')
    expect(page).to have_content('1968')
    expect(page).to have_content('Aldous Huxley')
  end

end
