require 'rails_helper'
describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:username) }
  end
  describe 'Relationship' do
    it { should have_many(:reviews) }
  end
end
