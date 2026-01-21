require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "assigns a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:valid_params) do
      {
        user: {
          name: "Test User",
          email: "test@example.com",
          password: "password123"
        }
      }
    end

    let(:invalid_params) do
      {
        user: {
          name: "",
          email: "",
          password: ""
        }
      }
    end

    context "with valid params" do
      it "creates a new user" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it "sets JWT cookie" do
        post :create, params: valid_params
        expect(cookies.signed[:jwt]).to be_present
      end

      it "redirects to movies path" do
        post :create, params: valid_params
        expect(response).to redirect_to(movies_path)
      end
    end

    context "with invalid params" do
      it "does not create a user" do
        expect {
          post :create, params: invalid_params
        }.to_not change(User, :count)
      end

      it "renders new template" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    let(:user) { create(:user) }

    it "assigns requested user" do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "renders edit template" do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    let(:user) { create(:user, name: "Old Name") }

    let(:update_params) do
      {
        id: user.id,
        user: { name: "New Name" }
      }
    end

    context "with valid params" do
      it "updates user details" do
        patch :update, params: update_params
        expect(user.reload.name).to eq("New Name")
      end

      it "redirects to movies path" do
        patch :update, params: update_params
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end
