
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'test@example.com')
      user.email = 'test@example.com'
      expect(user).to_not be_valid
    end
    
    it 'is not valid with an invalid email format' do
        user.email = 'invalid-email'
        expect(user).to_not be_valid
    end

    it 'requires a password' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a role' do
        user.role = nil
        expect(user).to_not be_valid
    end

  end
end



















































  # describe '#admin?' do
  #   it 'returns true if the user is an admin' do
  #     user.role = 'admin'
  #     byebug
  #     expect(user.admin?).to be(true)
  #   end

  #   it 'returns false if the user is not an admin' do
  #       user.role = 'user'
  #       expect(user.admin?).to be(false)
  #   end
  # end
