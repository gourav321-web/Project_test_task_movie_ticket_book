require 'rails_helper'

RSpec.describe "Shows", type: :request do
  let(:password) { "Gourav@12"}
  let(:user) { create(:user, email: "gourav@yopmail.com", password: password, password_confirmation: password)}
  let(:date_time) { DateTime.new(2021, 10, 23, 4, 17, 41) }
  let(:movie) { create(:movie, title: "Test Movie",description: "Test Description",duration: 120)}
  let(:show) { create(:show, show_time: date_time, available_seats: 120, seat_price: 200, movie: movie)}

  let(:valid_show_params) do
    { show: {show_time: date_time, available_seats: 100, seat_price: 200} }
  end

  let(:invalid_show_params) do 
    { show: {show_time: "", available_seat: 0, seat_price: 0} }
  end 

  before do
    post login_path, params: {email: user.email, password: password} 
  end

  describe "GET /Shows/new" do
    it "renders new show page" do
      get new_movie_show_path(movie)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /shows" do
    context "with valid params" do
      it "creates a show" do
        # byebug
        expect {post movie_shows_path( movie ), params: valid_show_params}.to change(Show, :count).by(1)
        expect(response).to redirect_to(movie_path(movie))
      end
    end


    context "with invalid params" do
      it "does not create show" do
        expect {post movie_shows_path( movie ), params: invalid_show_params}.not_to change(Show, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /shows/edit" do
    it "render edit show page" do
      # byebug
      get edit_movie_show_path(movie, show)
      expect(response).to have_http_status(:ok)
    end
  end
     

  describe "PATCH /movies/:id" do

    it "updates movie details" do
      # byebug
      patch movie_show_path(movie show), params: {
        show: { available_seats: 50 }
      }
      byebug

      expect(response).to redirect_to(movie_path(movie))
      # expect(movie.reload.title).to match(/New Title/i)
    end
  end
end















