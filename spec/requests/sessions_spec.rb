
require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:password) { "Gourav@123" }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  describe "GET /login" do
    it "returns success" do
      get login_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /login" do
    context "with valid credentials" do
      it "logs in user and set jwt cookie" do
        post login_path, params: {
          email: user.email,
          password: password
        }
        expect(response).to redirect_to(movies_path)
        expect(cookies[:jwt]).to be_present
      end
    end
    context "with invalid credentials" do
      it "does not login user" do
        post login_path, params: {
          email: user.email,
          password: "wrongpass"
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(cookies[:jwt]).to be_nil
      end
    end
  end

  describe "DELETE /logout" do
    it "logs out user and remove jwt cookie" do
      post login_path, params: {
        email: user.email,
        password: password
      }
      expect(cookies[:jwt]).to be_present
      delete logout_path
      expect(cookies[:jwt]).to be_blank
      # byebug
      expect(response).to redirect_to(login_path)
    end
  end
end