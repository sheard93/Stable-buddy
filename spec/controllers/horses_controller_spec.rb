require 'rails_helper'

RSpec.describe HorsesController, type: :controller do
  describe "horses#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "horses#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user
      
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "horses#create action" do
    it "should require users to be logged in" do
      post :create, params: { horse: { name: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new horse in the database" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      post :create, params: { horse: { name: "Hello!" } }
      expect(response).to redirect_to root_path
      horse = Horse.last
      expect(horse.name).to eq("Hello!")
      expect(horse.user).to eq(user)
    end
    it "should properly deal with validation errors" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      horse_count = Horse.count
      post :create, params: { horse: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Horse.count).to eq Horse.count
    end
  end

end
