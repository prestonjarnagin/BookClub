require 'rails_helper'

describe 'Author show page' do
  it 'user can see basic author info' do
    
    author_1 = Author.create(name: 'George Orwell')
    author_1.books.create(title: '1984', pages: 300, year: 1948)
    author_1.books.create(title: 'Animal Farm', pages: 345, year: 1940)
    author_1.books.create(title: 'Homage to Catalonia', pages: 456, year: 1950)

    visit '/authors/1'

    expect(page).to have_content("George Orwell")
    expect(page).to have_content("1984")
    expect(page).to have_content("Animal Farm")
    expect(page).to have_content("Homage to Catalonia")
    expect(page).to have_content("345")

  end
end
