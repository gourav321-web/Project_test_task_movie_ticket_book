class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_show, only: [:new, :create]

  def index
    @bookings = current_user.bookings.includes(show: :movie)
  end

  def new
    @booking = @show.bookings.new
  end

  def create
    @booking = @show.bookings.new(booking_params)
    @booking.user = current_user
    @booking.status = "confirmed"

    if @booking.save
      redirect_to bookings_path, notice: "Booking confirmed"
    else
      render :new
    end
  end

  private

  def set_show
    @show = Show.find(params[:show_id])
  end

  def booking_params
    params.require(:booking).permit(:number_of_seats)
  end
end
