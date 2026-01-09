class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show
  validates :number_of_seats, numericality: { greater_than: 0 }
  validates :status, presence: true
  validate :seats
  before_create :totalprice
  after_create :seatremove
  after_create :booking

  private
  def totalprice
    self.total_price = number_of_seats * show.seat_price
  end

  def seats
    if number_of_seats.present? && number_of_seats > show.available_seats
      errors.add(:number_of_seats,"exceeds available seats (only #{show.available_seats} left)")
    end
  end

  def seatremove
    show.update!(available_seats: show.available_seats - number_of_seats)
  end

  def booking
    UserMailer.booking_confirmation(self).deliver_later
  end
  
end
