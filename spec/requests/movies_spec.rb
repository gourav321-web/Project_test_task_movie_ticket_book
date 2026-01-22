# require 'rails_helper'

# # RSpec.describe "Movies", type: :request do
# #   describe "GET /index" do
# #     it "works! (now write some real specs)" do
# #       get movies_path

# #     end
# #   end
# # end



# # RSpec.describe PostsController, type: :controller do
# #   describe 'GET #index' do
# #     before { get :index }
# #     it { should respond_with(:success) }
# #     it { should render_template(:index) }
# #     # expect(assigns(:posts)).to match_array(@posts)
# #   end
# #   # ... other actions
# # end



# describe UsersController, type: :request do
#   # Define valid parameters for testing
#   let(:valid_params) do
#     {
#       movie: {
#         title: 'John',
#         description: 'johndoe@example.com',
#         duration: 'password123'
#       }
#     }
#   end

#   describe "POST #create" do
#     # it "permits the correct parameters for the user" do
#     #   should permit(:name :email, :password, :profile_picture).
#     #     for(:create, params: valid_params).
#     #     on(:user)
#     # end
    
#     it "creates a new movie" do
#       expect {
#         post :create, params: valid_params
#       }.to change(User, :count).by(1)
#     end
#   end
# end








require "rails_helper"

RSpec.describe "Movies", type: :request do
  let(:password) { "password123" }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  let(:valid_movie_params) do
    {
      movie: {
        title: "Test Movie",
        description: "Test Description",
        duration: 120
      }
    }
  end

  let(:invalid_movie_params) do
    {
      movie: {
        title: "",
        description: "",
        duration: nil
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

  describe "GET /movies" do
    it "renders movies index page" do
      get movies_path
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
        expect {
          post movies_path, params: invalid_movie_params
        }.not_to change(Movie, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /movies/:id" do
    let(:movie) { create(:movie) }

    it "shows movie details" do
      get movie_path(movie)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /movies/:id/edit" do
    let(:movie) { create(:movie) }

    it "renders edit movie page" do
      get edit_movie_path(movie)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /movies/:id" do
    let(:movie) { create(:movie, title: "Old Title") }

    it "updates movie details" do
      patch movie_path(movie), params: {
        movie: { title: "New Title" }
      }

      expect(response).to redirect_to(movie_path(movie))
      expect(movie.reload.title).to eq("New Title")
    end
  end

  describe "DELETE /movies/:id" do
    let!(:movie) { create(:movie) }

    it "deletes movie" do
      expect {
        delete movie_path(movie)
      }.to change(Movie, :count).by(-1)

      expect(response).to redirect_to(movies_path)
    end
  end

  describe "GET /movies/search" do
    let!(:movie) { create(:movie, title: "Avatar") }

    it "searches movie by title" do
      get search_movies_path, params: { key: "Avatar" }
      expect(response).to have_http_status(:ok)
    end
  end
end
