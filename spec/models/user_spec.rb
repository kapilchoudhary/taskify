require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:projects) }
    it { should have_many(:assigned_tasks).class_name('Task') }
    it { should have_many(:reported_tasks).class_name('Task') }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
