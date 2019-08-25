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

end