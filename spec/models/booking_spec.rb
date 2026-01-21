require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'validation' do 
    it { should validate_presence_of :seat_numbers}
  end

  describe 'association' do
    it { should belong_to :user } 
    it { should belong_to :show}
  end

  describe 'callback' do 
    it { should callback(:set_number_of_seats).before(:validation) }
    it { should callback(:totalprice).before(:validation)}
    it { should callback(:seatremove).after(:create)}
    it { should callback(:bookingmail).after(:create)}
  end
end
