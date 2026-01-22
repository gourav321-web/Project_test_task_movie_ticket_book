# require 'rails_helper'

# RSpec.describe "Shows", type: :request do
#   # describe "GET /shows" do
#   #   it "works! (now write some real specs)" do
#   #     get shows_index_path
#   #     expect(response).to have_http_status(200)
#   #   end
#   # end
# end









require "rails_helper"

RSpec.describe "Shows", type: :request do
  let(:password) { "password123" }
  let(:user) { create(:user, password: password, password_confirmation: password) }
  let(:movie) { create(:movie) }

  let(:show_params) do
    {
      show: {
        show_time: 2.days.from_now,
        available_seats: 50,
        seat_price: 200
      }
    }
  end

  before do
    # login user
    post login_path, params: {
      email: user.email,
      password: password
    }
  end

  describe "GET /movies/:movie_id/shows/new" do
    it "renders new show page" do
      get new_movie_show_path(movie)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /movies/:movie_id/shows" do
    context "with valid params" do
      it "creates a show" do
        expect {
          post movie_shows_path(movie), params: show_params
        }.to change(Show, :count).by(1)

        expect(response).to redirect_to(movie_path(movie))
      end
    end

    context "with invalid params" do
      it "does not create show" do
        expect {
          post movie_shows_path(movie), params: {
            show: { show_time: nil }
          }
        }.not_to change(Show, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /movies/:movie_id/shows/:id/edit" do
    let(:show) { create(:show, movie: movie) }

    it "renders edit page" do
      get edit_movie_show_path(movie, show)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /movies/:movie_id/shows/:id" do
    let(:show) { create(:show, movie: movie, available_seats: 40) }

    it "updates show details" do
      patch movie_show_path(movie, show), params: {
        show: { available_seats: 60 }
      }

      expect(response).to redirect_to(movie_path(movie))
      expect(show.reload.available_seats).to eq(60)
    end
  end

  describe "DELETE /movies/:movie_id/shows/:id" do
    let!(:show) { create(:show, movie: movie) }

    it "deletes the show" do
      expect {
        delete movie_show_path(movie, show)
      }.to change(Show, :count).by(-1)

      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe "GET /movies/:movie_id/shows/search_show" do
    let!(:future_show) do
      create(
        :show,
        movie: movie,
        show_time: 2.days.from_now
      )
    end

    it "filters shows by date" do
      get search_show_movie_shows_path(movie), params: {
        date: future_show.show_time.to_date
      }

      expect(response).to have_http_status(:ok)
    end

    it "filters shows by time" do
      get search_show_movie_shows_path(movie), params: {
        time: future_show.show_time.strftime("%H:%M")
      }

      expect(response).to have_http_status(:ok)
    end
  end
end
