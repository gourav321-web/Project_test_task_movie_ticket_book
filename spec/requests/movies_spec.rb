
require "rails_helper"

RSpec.describe "Movies", type: :request do
  let(:password) { "Gourav@12" }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  let(:valid_movie_params) do
    { movie: {title: "Test Movie",description: "Test Description",duration: 120} }
  end
  let(:invalid_movie_params) do
    { movie: {title: "",description: "",duration: nil} }
  end

  before do
    post login_path, params: {email: user.email,password: password}
  end

  describe "GET /movies" do
    it "renders movies index page" do
      get movies_path
      byebug
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /movies/new" do
    it "renders new movie page" do
      get new_movie_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /movies" do
    context "with valid params" do
      it "creates a movie" do
        expect {
          post movies_path, params: valid_movie_params
        }.to change(Movie, :count).by(1)

        expect(response).to redirect_to(movies_path)
      end
    end

    context "with invalid params" do
      it "does not create movie" do
        expect {post movies_path, params: invalid_movie_params}.not_to change(Movie, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe "GET /movies/:id" do
  #   let(:movie) { create(:movie, title: "border 2", description: "23rd jan", duration: 240) }

  #   it "shows movie details" do
  #     get movie_path(movie)
  #     expect(response).to have_http_status(:ok)
  #   end
  # end

  describe "GET /movies/:id/edit" do
    let(:movie) { create(:movie, title: "border 2", description: "23rd jan", duration: 240) }

    it "renders edit movie page" do
      get edit_movie_path(movie)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /movies/:id" do
    let(:movie) { create(:movie, title: "border 2", description: "23rd jan", duration: 240) }

    it "updates movie details" do
      patch movie_path(movie), params: {
        movie: { title: "New Title" }
      }

      expect(response).to redirect_to(movie_path(movie))
      expect(movie.reload.title).to match(/New Title/i)
    end
  end

  describe "DELETE /movies/:id" do
    let!(:movie) { create(:movie, title: "border 2", description: "23rd jan", duration: 240) }

    it "deletes movie" do
      expect {delete movie_path(movie)}.to change(Movie, :count).by(-1)

      expect(response).to redirect_to(movies_path)
    end
  end

  describe "GET /movies/search" do
    let!(:movie) { create(:movie, title: "Border 2 updated again", description: "dsvhnds", duration: 240) }

    it "searches movie by title" do
      get search_movies_path, params: { key: "Border 2 updated again" }
      expect(response).to have_http_status(:ok)
    end
  end
end