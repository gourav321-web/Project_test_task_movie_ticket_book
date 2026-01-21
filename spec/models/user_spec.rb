require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')

      expect(user).to_not be_valid
    end

    it 'is not valid with invalid email format' do
      user = build(:user, email: 'invalid-email')
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil, password_confirmation: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a role' do
      user = build(:user, role: nil)
      expect(user).to_not be_valid
    end
  end

  describe '#admin?' do
    it 'returns true when role is admin' do
      user = build(:user, role: 'admin')
      expect(user.admin?).to eq(true)
    end

    it 'returns false when role is user' do
      user = build(:user, role: 'user')
      expect(user.admin?).to eq(false)
    end
  end
end
