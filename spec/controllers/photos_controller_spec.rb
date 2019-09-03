require 'rails_helper'


RSpec.describe PhotosController, type: :controller do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
    end

  describe "photos#new action" do
    it "should successfully show the new form" do
          get :new
          expect(response).to have_http_status(:success)
    end
  end

  describe "photos#create action" do
    it "should require users to be logged in" do
        post :create, params: { photo: { caption: 'DisneyLand Photo', picture: 'test.jpg' } }
        expect(response).to redirect_to user_photos_path(user)
    end
    
    it "should successfully create a new photo in our database" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        post :create, params: { photo: { caption: 'DisneyLand Photo', picture: 'test.jpg' } }
        expect(response).to redirect_to user_photos_path(user)
    
        photo = Photo.last
        expect(photo.caption).to eq("DisneyLand Photo")
    end

    it "should properly deal with validation errors" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        photo_count = Photo.count
        post :create, params: { photo: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Photo.count).to eq photo_count
    end
  end

  describe "photos#update action" do
    it "shouldn't let unauthenticated users update a photo" do
        photo = FactoryBot.create(:photo)
        user = FactoryBot.create(:user)
        sign_in user
        patch :update, params: { id: photo.id, photo: { caption: 'Disneyland' } }
        expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users update a photo" do
        photo = FactoryBot.create(:photo)
        get :update, params: { id: photo.id, gram: { caption: 'Disneyland' } }
        expect(response).to redirect_to user_photos_path(current_user)
    end
  
    it "should allow users to successfully update photos" do
        gram = FactoryBot.create(:photo, message: "Initial Value")
        sign_in gram.user
        patch :update, params: { id: photo.id, photo: {caption: 'Changed'}}
        expect(response).to redirect_to user_photos_path(current_user)
        photo.reload
        expect(photo.cpation).to eq "Changed"

    end

    it "should have http 404 error if the photo cannot be found" do
        user = FactoryBot.create(:user)
        sign_in user

        patch :update, params: { id: "YOLOSWAG", photo: { caption: 'Changed' } }
        expect(response).to have_http_status(:not_found)          
    end

    it "should render the edit form with an http status of unprocessable_entity" do
        photo = FactoryBot.create(:photo, caption: "Initial Value")
        sign_in photo.user
        patch :update, params: { id: photo.id, photo: { caption: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        photo.reload
        expect(photo.caption).to eq "Initial Value"
      
    end
  end


describe "photos#edit action" do
    it "shouldn't let a user who did not create the photo edit a photo" do
        gram = FactoryBot.create(:photo)
        user = FactoryBot.create(:user)
        sign_in user
        get :edit, params: {id: photo.id}
        expect(response).to have_http_status(:forbidden)
    end
  
    it "shouldn't let unauthenticated users edit a photo" do
        gram = FactoryBot.create(:photo)
        get :edit, params: { id: photo.id }
        expect(response).to redirect_to user_photos_path(current_user)
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