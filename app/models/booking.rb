class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show

  validates :number_of_seats, presence: true, numericality: { greater_than: 0 }
  validate :seats
  before_validation :totalprice
  after_create :seatremove
  after_create :bookingmail

  private

  def totalprice
    return if number_of_seats.blank?
    return if show.blank?
    return if show.seat_price.blank?

    self.total_price = number_of_seats * show.seat_price
  end

  def seats
    return if number_of_seats.blank?
    return if show.blank?
    return if show.available_seats.blank?

    if show.available_seats <= 0
      errors.add(:number_of_seats, "no seats available")
    elsif number_of_seats > show.available_seats
      errors.add(:number_of_seats, "insufficient seats")
    end
  end

  def seatremove
    return if number_of_seats.blank?
    return if show.blank?
    return if show.available_seats.blank?

    show.update!(available_seats: show.available_seats - number_of_seats)
  end

  def bookingmail
    UserMailer.booking_confirmation(self).deliver_later
  end
end
