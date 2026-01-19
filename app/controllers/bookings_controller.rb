class BookingsController < ApplicationController
  before_action :authtouser
  before_action :setshow, only: [:new, :create]

  def index
    @bookings = current_user.bookings.includes(show: :movie)
  end

  def new
    @booking = @show.bookings.new
    @booked_seats = @show.bookings.pluck(:seat_numbers).join(",").split(",")
  end

  def create
    @booking = @show.bookings.new(booking_params)
    @booking.user = current_user
    @booking.status = "book"
    if @booking.save

     show_time = @booking.show.show_time
     reminder_time = show_time - 1.hour

     if reminder_time > Time.current
      # ShowReminderJob.set(wait_until: reminder_time).perform_later(@booking.id)
      # byebug
      # SendShowReminderJob.perform_now(@booking.id)
     end
    
      @show      = @booking.show
      show_time = @show.show_time
      reminder_time = show_time - 1.hour
      if reminder_time > Time.current
        # byebug
        # SendShowReminderJob.set
        byebug
        SendShowReminderJob.set(wait: 1.minutes).perform_later(@booking.id)
        # SendShowReminderJob.set(wait_until: reminder_time).perform_later(@booking.id)

        # SendShowReminderJob.perform_now(@booking.id)
      end

      redirect_to bookings_path, notice: "Booking complete"
    else
      @booked_seats = @show.bookings.pluck(:seat_numbers).join(",").split(",")
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
