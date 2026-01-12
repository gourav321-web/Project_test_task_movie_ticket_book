class Show < ApplicationRecord
  belongs_to :movie
  has_many :bookings, dependent: :destroy
  validates :show_time, presence: true
  validates :available_seats, presence: true
  validates :seat_price, presence: true
end
