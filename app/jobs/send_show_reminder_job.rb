class SendShowReminderJob < ApplicationJob
  queue_as :default
  
  def perform(booking_id)
    @booking = Booking.find_by_id(booking_id)
    user = @booking.user
    user_email = user.email
    show = @booking.show
    UserMailer.show_reminder(user, user_email,show).deliver_now
    Rails.logger.info "This is an info message."
  end
end








# show_time = @booking.show.show_time
#     reminder_time = show_time - 1.hour

#     # Schedule the job to run at the specific time
#     # Sidekiq uses perform_at for delayed jobs
#     ReminderEmailJob.set(wait_until: reminder_time).perform_later(@booking.user.id, @booking.show.id)