require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /register" do
    it "it render new view page" do
      get register_path

      expect(response).to be_successful

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

  end

  describe "POST /users" do
    context "with valid parameters" do
      let(:user_params) do
        {user: {name: "Gourav",email:"gourav@gmail.com", password:"Gourav@12"}} 
      end
      
      it "it create a new user and return 201 status" do
        byebug
        expect(user_).to be_successful
        # expect(response).to have_http_status(:created)
      end
    end
  end
end
