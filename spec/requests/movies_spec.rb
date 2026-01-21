require 'rails_helper'

# RSpec.describe "Movies", type: :request do
#   describe "GET /index" do
#     it "works! (now write some real specs)" do
#       get movies_path

#     end
#   end
# end



# RSpec.describe PostsController, type: :controller do
#   describe 'GET #index' do
#     before { get :index }
#     it { should respond_with(:success) }
#     it { should render_template(:index) }
#     # expect(assigns(:posts)).to match_array(@posts)
#   end
#   # ... other actions
# end



describe UsersController, type: :request do
  # Define valid parameters for testing
  let(:valid_params) do
    {
      movie: {
        title: 'John',
        description: 'johndoe@example.com',
        duration: 'password123'
      }
    }
  end

  describe "POST #create" do
    # it "permits the correct parameters for the user" do
    #   should permit(:name :email, :password, :profile_picture).
    #     for(:create, params: valid_params).
    #     on(:user)
    # end
    
    it "creates a new movie" do
      expect {
        post :create, params: valid_params
      }.to change(User, :count).by(1)
    end
  end
end