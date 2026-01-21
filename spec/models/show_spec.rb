require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'validations' do
    it { should validate_presence_of :show_time }
    it { should validate_presence_of :available_seats }
    it { should validate_numericality_of(:available_seats).is_greater_than(0)}
    it {should validate_numericality_of(:available_seats).is_less_than_or_equal_to(120)}
    it { should validate_numericality_of(:available_seats).only_integer}
    it { should validate_presence_of :seat_price }
  end

  describe 'association' do 
    it { should belong_to :movie}
    it { should have_many(:bookings).dependent(:destroy)}
  end
end
