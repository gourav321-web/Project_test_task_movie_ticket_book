class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to BookMyShow")
  end

  def booking_confirmation(booking)
    @booking = booking
    @user = booking.user
    @show = booking.show
    @movie = @show.movie
    mail(to: @user.email,subject: "Booking Confirmed:#{@movie.title}")
  end
end
