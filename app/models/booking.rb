class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show


  validates :seat_numbers, presence: true
  validate :seat_validation

  before_validation :set_number_of_seats
  before_validation :totalprice
  after_create :seatremove
  after_create :bookingmail

  def cancellable
    Time.current < (show.show_time - 2.hours)
  end

  private

  def set_number_of_seats
    return if seat_numbers.blank?
    self.number_of_seats = seat_numbers.split(",").length
  end

  def totalprice
    return if number_of_seats.blank? || show.blank?
    self.total_price = number_of_seats * show.seat_price
  end

  def seat_validation
    return if seat_numbers.blank? || show.blank?

    selected = seat_numbers.split(",")

    already_booked = show.bookings.pluck(:seat_numbers).join(",").split(",")

    if (selected & already_booked).any?
      errors.add(:seat_numbers, "some seats already booked")
    end

    if selected.length > show.available_seats
      errors.add(:seat_numbers, " enough seats are not available")
    end
  end

  def seatremove
    Show.where(id: show_id)
        .update_all("available_seats = available_seats - #{number_of_seats}")
  end

  def bookingmail
    # byebug
    UserMailer.booking_confirmation(self).deliver_later
  end
end















































































  # scope :expired_shows, -> {
  #   joins(:show).where("shows.show_time < ?", Time.current)
  # }
