class BookingsController < ApplicationController
  before_action :authtouser
  before_action :setshow, only: [:new, :create]

  def index
    @bookings = current_user.bookings.includes(show: :movie)
  end

  def new
    @booking = @show.bookings.new
    @booked_seats = @show.bookings.pluck(:seat_numbers)
                                 .join(",")
                                 .split(",")
  end

  def create
    @booking = @show.bookings.new(booking_params)
    @booking.user = current_user
    @booking.status = "book"

    if @booking.save
      redirect_to bookings_path, notice: "Booking complete"
    else
      @booked_seats = @show.bookings.pluck(:seat_numbers)
                                   .join(",")
                                   .split(",")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def setshow
    @show = Show.find(params[:show_id])
  end

  def booking_params
    params.require(:booking).permit(:seat_numbers)
  end
end
