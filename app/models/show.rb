class Show < ApplicationRecord
  belongs_to :movie
  has_many :bookings, dependent: :destroy
  validates :show_time, presence: true
  validates :available_seats, presence: true, numericality: {only_integer: true,greater_than: 0,less_than_or_equal_to: 120}
  validates :seat_price, presence: true
end
