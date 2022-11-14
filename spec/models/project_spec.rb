require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
    it { should have_many(:description) }
  end

  describe 'validations' do
    binding.pry
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_length_of(:title).is_at_least(10) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(10) }
  end
end
