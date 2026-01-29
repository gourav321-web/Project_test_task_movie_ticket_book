class UpdateBookingStatusJob < ApplicationJob
  queue_as :default

  def perform(*args)
    bookings_to_update = Booking.where("show_time < ?", Time.current)
    bookings_to_update.find_each do |booking|
      booking.update(show_status: 'complete')
    end
  end
end
