require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do

    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
    end

  describe "albums#new action" do
    it "should successfully show the new form" do
          get :new
          expect(response).to have_http_status(:success)
    end
  end

  describe "albums#create action" do
    it "should require users to be logged in" do
        post :create, params: { person: { name: 'my Album'} }
        expect(response).to redirect_to album_path
    end
    
    it "should successfully create a new album in our database" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        post :create, params: { album: { name: 'my Album'} }
        expect(response).to redirect_to album_path
    
        album = Album.last
        expect(album.name).to eq("my Album")

    end

    it "should properly deal with validation errors" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        album_count = Album.count
        post :create, params: { album: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Album.count).to eq album_count
    end
  end

end