class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show

  validates :number_of_seats, numericality: { greater_than: 0 }
  validates :status, presence: true

  validate :check_seat_availability

  before_create :calculate_total_price
  after_create :reduce_show_seats
  after_create :send_confirmation_email

  private

  def calculate_total_price
    self.total_price = number_of_seats * show.seat_price
  end

  def check_seat_availability
    if number_of_seats.present? && number_of_seats > show.available_seats
      errors.add(
        :number_of_seats,
        "exceeds available seats (only #{show.available_seats} left)"
      )
    end
  end

  def reduce_show_seats
    show.update!(
      available_seats: show.available_seats - number_of_seats
    )
  end

  def send_confirmation_email
    UserMailer.booking_confirmation(self).deliver_later
  end
  
end
