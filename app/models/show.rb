class Show < ApplicationRecord
  belongs_to :movie
  has_many :bookings, dependent: :destroy

  validates :show_time, presence: true
  validates :available_seats, numericality: { greater_than_or_equal_to: 0 }
  validates :seat_price, numericality: { greater_than: 0 }
end
