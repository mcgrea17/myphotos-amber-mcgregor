require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do


  describe "albums#new action" do
    it "should successfully show the new form" do
        user = FactoryBot.create(:user)
        sign_in user
          get :new
          expect(response).to have_http_status(:success)
    end
  end

  

  describe "albums#create action" do
    it "should require users to be logged in" do
       
        post :create, params: { album: { name: 'my Album', startDate: "2019-08-08", endDate: "2019-08-14"} }
        expect(response).to redirect_to new_user_session_path
    end
    
    it "should successfully create a new album in our database" do
        user = FactoryBot.create(:user)
        sign_in user
    
        album = FactoryBot.create(:album)
        expect(response).to have_http_status(:success)

    end

    it "should properly deal with validation errors" do
        user = FactoryBot.create(:user)
        sign_in user
    
        album_count = Album.count
        post :create, params: { album: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Album.count).to eq album_count
    end
  end

end