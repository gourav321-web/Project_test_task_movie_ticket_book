require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do 
    it { is_expected.to validate_presence_of(:title) }
    it {should validate_presence_of :description}
    it {should validate_presence_of :duration}
  end

  describe 'callback' do 
    it { should callback(:capitalize_fields).before(:save) }
  end

  describe 'association' do 
    it {should have_many :shows}
    it { should have_many(:shows).dependent(:destroy) }
    it { should have_one_attached(:banner_image) }

  end

  # describe "capitalize" do
  #   it "capitalize an title and description before movie save" do
  #     
  #   end
  # end

end
