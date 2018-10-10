require 'rails_helper'
describe Book, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:year) }
    # it { should validate_presence_of(:author_ids) }
    it { should validate_presence_of(:pages) }
  end
  describe 'Relationship' do
    it { should have_many(:book_authors) }
    it { should have_many(:authors).through(:book_authors) }
  end
end
