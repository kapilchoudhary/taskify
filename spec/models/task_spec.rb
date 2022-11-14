require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { should belong_to(:project) }
    it { should belong_to(:assignee) }
    it { should belong_to(:reporter) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_length_of(:title).is_at_least(10) }
    it { should validate_presence_of(:content) }
  end
end
