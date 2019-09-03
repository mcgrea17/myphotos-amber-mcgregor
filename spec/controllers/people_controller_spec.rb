require 'rails_helper'


RSpec.describe PeopleController, type: :controller do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
    end

  describe "people#new action" do
    it "should successfully show the new form" do
          get :new
          expect(response).to have_http_status(:success)
    end
  end

  describe "people#create action" do
    it "should require users to be logged in" do
        post :create, params: { person: { firstName: 'Tom', lastName: 'Smith', birthday: '2006-02-06' } }
        expect(response).to redirect_to new_person_path
    end
    
    it "should successfully create a new person in our database" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        post :create, params: { person: { firstName: 'Tom', lastName: 'Smith', birthday: '2006-02-06'} }
        expect(response).to redirect_to new_person_path
    
        person = Person.last
        expect(person.firstName).to eq("Tom")
        expect(person.lastName).to eq("Smith")

    end

    it "should properly deal with validation errors" do
        user = User.create(
            email:                 'fakeuser@gmail.com',
            password:              'secretPassword',
            password_confirmation: 'secretPassword'
          )
          sign_in user
    
        person_count = Person.count
        post :create, params: { person: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Person.count).to eq person_count
    end
  end

end