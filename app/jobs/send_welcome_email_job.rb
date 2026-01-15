class SendWelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    UserMailer.booking_confirmation(user).deliver_now
  end
end
