require 'rails_helper'


RSpec.describe PhotosController, type: :controller do
    let(:location) { FactoryBot.create(:location) }




  describe "photos#new action" do

    it "should successfully show the new form" do
        user = FactoryBot.create(:user)
        sign_in user
          get :new
          expect(response).to have_http_status(:success)
    end
  end

  describe "photos#create action" do
    
    
    it "should successfully create a new photo in our database" do
        user = FactoryBot.create(:user)
        sign_in user
        photo = FactoryBot.create(:photo)
        expect(response).to have_http_status(:success)
        
    end

    it "should properly deal with validation errors" do
        user = FactoryBot.create(:user)
        sign_in user    
    
        photo_count = Photo.count
        post :create, params: { photo: { caption: '', picture: fixture_file_upload("/picture.png", 'image/png') } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Photo.count).to eq photo_count
    end
  end

  describe "photos#update action" do
    it "shouldn't let unauthenticated users update a photo" do
        location = FactoryBot.create(:location)
        photo = FactoryBot.create(:photo, location_id: location.id)
        user = FactoryBot.create(:user)
        sign_in user
        patch :update, params: { id: photo.id, photo: { caption: 'Disneyland' } }
        expect(response).to have_http_status(:forbidden)
    end

  
    it "should allow users to successfully update photos" do
        photo = FactoryBot.create(:photo)
        sign_in photo.user
        patch :update, params: { id: photo.id, photo: {caption: 'Changed'}}
        
        photo.reload
        expect(photo.caption).to eq "Changed"
        expect(response).to redirect_to user_photos_path(photo.user)

    end

    it "should have http 404 error if the photo cannot be found" do
        user = FactoryBot.create(:user)
        sign_in user

        expect { patch :update, params: { id: "YOLOSWAG", photo: { caption: 'Changed' } } }.to raise_exception(ActiveRecord::RecordNotFound)
    
    end

    it "should render the edit form with an http status of unprocessable_entity" do
        photo = FactoryBot.create(:photo)
        sign_in photo.user
        patch :update, params: { id: photo.id, photo: { picture: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
    end
  end


describe "photos#edit action" do
    it "shouldn't let a user who did not create the photo edit a photo" do
       
        photo = FactoryBot.create(:photo)
        user = FactoryBot.create(:user)
        sign_in user
        get :edit, params: {id: photo.id}
        expect(response).to have_http_status(:forbidden)
    end
  
   
#     it "should successfully show edit form if the gram is found" do
#         gram = FactoryBot.create(:gram)
#         sign_in gram.user
#         get :edit, params: {id: gram.id}
#         expect(response).to have_http_status(:success)
#     end

#     it "should return a 404 error message if the gram is not found" do
#         user = FactoryBot.create(:user)
#         sign_in user
#         get :edit, params: { id: 'TACOCAT' }
#         expect(response).to have_http_status(:not_found)
#     end
# end

# describe "gram#show action" do
#     it "should successfully show the page if the gram is found" do
#         gram = FactoryBot.create(:gram)
#         get :show, params: {id: gram.id}
#         expect(response).to have_http_status(:success)
#     end

#     it "should return a 404 error if the gram is not found" do
#         get :show, params: { id: 'TACOCAT' }
#         expect(response).to have_http_status(:not_found)
#     end

# end

# describe "grams#destroy action" do
#     it "shouldn't let a user who did not create the gram edit a gram" do
#         gram = FactoryBot.create(:gram)
#         user = FactoryBot.create(:user)
#         sign_in user
#         delete :destroy, params: { id: gram.id }
#         expect(response).to have_http_status(:forbidden)
#     end

#     it "shouldn't let unauthenticated users destroy a gram" do
#         gram = FactoryBot.create(:gram)
#         delete :destroy, params: { id: gram.id }
#         expect(response).to redirect_to new_user_session_path
#     end
    
#     it "should allow a user to destroy grams" do
        
#         gram = FactoryBot.create(:gram)
#         sign_in gram.user
#         delete :destroy, params: { id: gram.id}
#         expect(response).to redirect_to root_path
#         gram = Gram.find_by_id(gram.id)
#         expect(gram).to eq nil

#     end

#     it "should return a 404 message if we cannot find a gram with the id that is specified" do
#         user = FactoryBot.create(:user)
#         sign_in user
#         delete :destroy, params: { id: 'SPACEDUCK'}
#         expect(response).to have_http_status(:not_found)
#     end
  end

end