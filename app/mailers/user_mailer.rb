class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to BookMyShow")
  end

  def booking_confirmation(booking)
    # byebug
    @booking = booking
    @user = booking.user
    @show = booking.show
    @movie = @show.movie
    mail(to: @user.email,subject: "Booking Confirmed:#{@movie.title}")
  end


  def show_reminder(user, email, show)
    # byebug
    @user = user
    @show = show
    # # @show = show
    mail(to: email, subject: "Reminder: Your show is in 1 hour!")
  end
end
