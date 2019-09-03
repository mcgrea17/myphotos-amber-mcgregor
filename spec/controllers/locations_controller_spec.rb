require 'rails_helper'


RSpec.describe LocationsController, type: :controller do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
    end

  describe "locations#new action" do
    it "should successfully show the new form" do
          get :new
          expect(response).to have_http_status(:success)
    end
  end

  describe "locations#create action" do
    it "should require users to be logged in" do
        post :create, params: { location: { name: 'DisneyLand' } }
        expect(response).to redirect_to new_location_path
    end
    
    it "should successfully create a new location in our database" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        post :create, params: { location: { name: 'DisneyLand' } }
        expect(response).to redirect_to new_location_path
    
        location = Location.last
        expect(location.name).to eq("DisneyLand")
    end

    it "should properly deal with validation errors" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        location_count = Location.count
        post :create, params: { location: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Location.count).to eq location_count
    end
  end

  describe "people#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "photos#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "albums#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end