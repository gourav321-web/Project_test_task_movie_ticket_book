# # require 'rails_helper'

# # RSpec.describe "Users", type: :request do

# #   # describe "GET /register" do
# #   #   it "it render new view page" do
# #   #     get register_path

# #   #     expect(response).to be_successful

# #   #     expect(response).to have_http_status(:success)
# #   #     expect(response).to render_template(:new)
# #   #   end

# #   # end

# #   # describe "POST /users" do
# #   #   context "with valid parameters" do
# #   #     let(:user_params) do
# #   #       {user: {name: "Gourav",email:"gourav@gmail.com", password:"Gourav@12"}} 
# #   #     end
      
# #   #     it "it create a new user and return 201 status" do
# #   #       byebug
# #   #       expect(user_).to be_successful
# #   #       # expect(response).to have_http_status(:created)
# #   #     end
# #   #   end
# #   # end

# #   # it { should filter_param(:password) }
# # end





# # spec/controllers/users_controller_spec.rb
# require 'rails_helper'

# describe UsersController, type: :request do
#   # Define valid parameters for testing
#   let(:valid_params) do
#     {
#       user: {
#         name: 'John',
#         email: 'johndoe@example.com',
#         password: 'password123'
#       }
#     }
#   end

#   describe "POST #create" do
#     # it "permits the correct parameters for the user" do
#     #   should permit(:name :email, :password, :profile_picture).
#     #     for(:create, params: valid_params).
#     #     on(:user)
#     # end
    
#     it "creates a new user" do
#       expect {
#         post :create, params: valid_params
#       }.to change(User, :count).by(1)
#     end

#     it "redirects to the created user" do
#       post :create, params: valid_params
#       # This uses the 'redirect_to' matcher
#       should redirect_to(user_path(assigns(:user)))
#     end

#     it "assigns the created user to @user" do
#       post :create, params: valid_params
#       # This uses the 'assign_to' matcher (available in older shoulda-matchers versions, though often replaced by standard RSpec assigns methods)
#       expect(assigns(:user)).to be_a(User)
#       expect(assigns(:user)).to be_persisted
#     end
#   end
# end



require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:password) { "password123" }

  let(:user) do
    create(
      :user,
      password: password,
      password_confirmation: password
    )
  end

  describe "GET /register" do
    it "renders signup page" do
      get register_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users" do
    context "with valid params" do
      it "creates user and sets jwt cookie" do
        post users_path, params: {
          user: {
            name: "Test User",
            email: "testuser@example.com",
            password: password,
            password_confirmation: password
          }
        }

        expect(response).to redirect_to(movies_path)
        expect(cookies.signed[:jwt]).to be_present
      end
    end

    context "with invalid params" do
      it "does not create user" do
        expect {
          post users_path, params: {
            user: {
              name: "",
              email: "",
              password: ""
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /users/:id/edit" do
    it "renders edit page" do
      get edit_user_path(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /users/:id" do
    it "updates user profile" do
      patch user_path(user), params: {
        user: {
          name: "Updated Name"
        }
      }

      expect(response).to redirect_to(movies_path)
      expect(user.reload.name).to eq("Updated Name")
    end
  end
end
