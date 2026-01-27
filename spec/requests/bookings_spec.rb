require "rails_helper"

RSpec.describe "Bookings", type: :request do
  let!(:user) do
    User.create!(name: "Test User",email: "user@test.com", password: "Gourav@12",password_confirmation: "Gourav@12",role: "user")
  end

  let!(:movie) do
    Movie.create!(title: "Avengers",description: "Action movie",duration: 200)
  end

  let!(:show) do
    Show.create!(movie: movie,show_time: 5.hours.from_now,total_seats: 50,available_seats: 50,seat_price: 200)
  end

  before do
    post login_path, params: {email: user.email,password: user.password}
  end

  describe "GET /bookings" do
    it "shows current user's bookings" do
      booking = Booking.create!(user: user,show: show,seat_numbers: "A1,A2",status: "book")

      get bookings_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Avengers")
    end
  end

  describe "GET /shows/:show_id/bookings/new" do
    it "renders seat booking page" do
      get new_show_booking_path(show)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Book Now")
    end
  end

  describe "POST /shows/:show_id/bookings" do
    context "when booking is valid" do
      it "creates booking and reduces available seats" do
        expect {
          post show_bookings_path(show), params: {
            booking: { seat_numbers: "A1,A2,A3" }
          }
        }.to change(Booking, :count).by(1)

        booking = Booking.last

        expect(booking.user).to eq(user)
        expect(booking.status).to eq("book")
        expect(booking.number_of_seats).to eq(3)
        expect(booking.total_price).to eq(600)

        expect(show.reload.available_seats).to eq(47)
        expect(response).to redirect_to(bookings_path)
      end
    end

    context "when seat already booked" do
      before do
        Booking.create!(user: user,show: show,seat_numbers: "A1",status: "book")
        byebug
      end

      it "does not create booking" do
        expect {
          post show_bookings_path(show), params: {
            booking: { seat_numbers: "A1,A2" }
          }
        }.not_to change(Booking, :count)
        
        byebug
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("some seats already booked")
      end
    end
  end

  describe "PATCH /bookings/:id/cancel" do
	context "when booking is cancellable" do
	    it "cancels booking" do
	      booking = Booking.create!(user: user,show: show,seat_numbers: "B1,B2",status: "book")

	      patch cancel_booking_path(booking)

	      expect(booking.reload.status).to eq("cancelled")
	      expect(response).to redirect_to(bookings_path)
	    end
	end

	context "when booking is not cancellable" do
	   it "does not cancel booking" do
	      show.update!(show_time: 1.hour.from_now, seat_price: show.seat_price.to_i)

	      booking = Booking.create!(user: user,show: show,seat_numbers: "C1",status: "book")

	      patch cancel_booking_path(booking)

	      expect(booking.reload.status).to eq("book")
	      expect(response).to redirect_to(bookings_path)
	   end
	end
  end

end