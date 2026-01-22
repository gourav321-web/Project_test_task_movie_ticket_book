# require 'rails_helper'

# RSpec.describe "Sessions", type: :request do
#   # describe "GET /sessions" do
#   #   it "works! (now write some real specs)" do
#   #     get sessions_index_path
#   #     expect(response).to have_http_status(200)
#   #   end
#   # end

#   describe "GET #new" do

#   #   it "renders the new template" do
#   #     expect(response).to_not render_template(:new)
#   #   end

#   #   it "does not set session data" do
#   #     expect(session[:user_id]).to be_nil
#   #   end
#   end


# #   describe "POST #create" do
# #   let(:user) { create(:user) }
# #   context "with valid credentials" do
# #     before { post :create, params: { session: { email: user.email, password: user.password } } }
# #     it { should set_cookies.signed[:jwt] } 
# #     # it { should set_flash[:alert].to('Logged-in') }
# #     # it { should redirect_to movies_path }
# #   end

# # #   context "with invalid credentials" do
# # #     before { post :create, params: { session: { email: "helo", password: "wrong" } } }
# # #     it { should_not set_cookies.signed[:jwt] } 
# # #     it { should set_flash[:alert].to('Invalid email or password') }
# # #     it { should render_template :new }
# # #   end
# # end


# end



# require "rails_helper"

# RSpec.describe "Sessions", type: :request do
#   let(:user) { create(:user, password: "password123") }

#   describe "GET /login" do
#     it "renders login page" do
#       get login_path
#       expect(response).to have_http_status(:ok)
#     end
#   end

#   describe "POST /login" do
#     context "with valid credentials" do
#       before do
#         post login_path, params: {
#           email: user.email,
#           password: "password123"
#         }
#       end

#       it "sets jwt cookie" do
#         expect(cookies.signed[:jwt]).to be_present
#       end

#       it "redirects to movies path" do
#         expect(response).to redirect_to(movies_path)
#       end
#     end

#     context "with invalid credentials" do
#       before do
#         post login_path, params: {
#           email: user.email,
#           password: "wrongpassword"
#         }
#       end

#       it "does not set jwt cookie" do
#         expect(cookies.signed[:jwt]).to be_nil
#       end

#       it "renders login again with error" do
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
#   end

#   describe "DELETE /logout" do
#     before do
#       post login_path, params: {
#         email: user.email,
#         password: "password123"
#       }

#       delete logout_path
#     end

#     it "clears jwt cookie" do
#       expect(cookies[:jwt]).to be_nil
#     end

#     it "redirects to login page" do
#       expect(response).to redirect_to(login_path)
#     end
#   end
# end








require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:password) { "password123" }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  describe "GET /login" do
    it "returns success" do
      get login_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /login" do
    context "with valid credentials" do
      it "logs in user and sets jwt cookie" do
        post login_path, params: {
          email: user.email,
          password: password
        }

        expect(response).to redirect_to(movies_path)
        expect(cookies.signed[:jwt]).to be_present
      end
    end

    context "with invalid credentials" do
      it "does not login user" do
        post login_path, params: {
          email: user.email,
          password: "wrongpass"
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(cookies.signed[:jwt]).to be_nil
      end
    end
  end

  describe "DELETE /logout" do
    it "logs out user and clears jwt cookie" do
      # login first
      post login_path, params: {
        email: user.email,
        password: password
      }

      expect(cookies.signed[:jwt]).to be_present

      # logout
      delete logout_path

      expect(cookies[:jwt]).to be_nil
      expect(response).to redirect_to(login_path)
    end
  end
end

