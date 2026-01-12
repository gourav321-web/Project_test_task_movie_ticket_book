class Show < ApplicationRecord
  belongs_to :movie
  has_many :bookings, dependent: :destroy
  validates :show_time, presence: true
  validates :available_seats, presence: true
  validates :seat_price, presence: true
  # before_create :seats 

  # def seats
  #   if show.available_seats >= 120
  #     errors.add(:number_of_seats, "only 120 seats are available")
  # end
end
