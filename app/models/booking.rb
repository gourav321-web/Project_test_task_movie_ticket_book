class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show
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
      errors.add(:number_of_seats,"seats are not present as much you entered(only #{show.available_seats} are present)")
    end
  end
  def seatremove
    show.update!(available_seats: show.available_seats - number_of_seats)
  end
  def booking
    UserMailer.booking_confirmation(self).deliver_later
  end
  
end
