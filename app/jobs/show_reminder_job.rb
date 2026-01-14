class ShowReminderJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    booking = Booking.find_by(id: booking_id)
    return unless booking

    UserMailer.show_reminder(booking).deliver_now
  end
end
