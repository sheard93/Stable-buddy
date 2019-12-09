require 'rails_helper'

RSpec.describe HorsesController, type: :controller do
  describe "horses#destroy action" do
    it "shouldn't allow users who didn't create the horse to destroy it" do
      horse = FactoryBot.create(:horse)
      user = FactoryBot.create(:user)
      sign_in user 
      delete :destroy, params: { id: horse.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users destroy a horse" do
      horse = FactoryBot.create(:horse)
      delete :destroy, params: { id: horse.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow a user to destroy horses" do
      horse = FactoryBot.create(:horse)
      sign_in horse.user
      delete :destroy, params: { id: horse.id }
      expect(response).to redirect_to root_path
      horse = Horse.find_by_id(horse.id)
      expect(horse).to eq nil
    end

    it "should return a 404 message if we cannot find a horse with the id that is specified" do
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "horses#update action" do
    it "shouldn't let users who didn't create the horse update it" do
      horse = FactoryBot.create(:horse)
      user= FactoryBot.create(:user)
      sign_in user
      patch :update, params: { id: horse.id, horse: { name: 'Wahoo' } }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users update a horse" do
      horse = FactoryBot.create(:horse)
      patch :update, params: { id: horse.id, horse: { name: 'Hello' } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to successfully update horses" do
      horse = FactoryBot.create(:horse, name: "Initial Value")
      sign_in horse.user
      patch :update, params: { id: horse.id, horse: { name: 'Changed' } }
      expect(response).to redirect_to root_path
      horse.reload
      expect(horse.name).to eq "Changed"
    end

    it "should have http 404 error if the horse cannot be found" do
      user = FactoryBot.create(:user)
      sign_in user

      patch :update, params: { id: "YOLOSWAG", horse: { name: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      horse = FactoryBot.create(:horse, name: "Initial Value")
      sign_in user 
      patch :update, params: { id: horse.id, horse: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      horse.reload
      expect(horse.name).to eq "Initial Value"
    end
  end



  describe "horses#edit action" do
    it "shouldn't let a user who did not create the horse edit the horse" do
      horse = FactoryBot.create(:horse)
      user = FactoryBot.create(:user)
      sign_in user 
      get :edit, params: { id: horse.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users edit a horse" do
      horse = FactoryBot.create(:horse)
      get :edit, params: { id: horse.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the edit form if the horse is found" do
      horse = FactoryBot.create(:horse)
      sign_in horse.user
      get :edit, params: { id: horse.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the gram is not found" do
      user = FactoryBot.create(:user)
      sign_in user 

      get :edit, params: { id: 'SWAG' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "horses#show action" do
    it "should successfully show the page if the horse is found" do
      horse = FactoryBot.create(:horse)
      get :show, params: { id: horse.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
      get :show, params: { id: 'Tacocat' }
      expect(response).to have_http_status(:not_found)
    end
  end

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
      user = FactoryBot.create(:user)
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
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { horse: { name: "Hello!" } }
      expect(response).to redirect_to root_path
      horse = Horse.last
      expect(horse.name).to eq("Hello!")
      expect(horse.user).to eq(user)
    end
    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      horse_count = Horse.count
      post :create, params: { horse: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Horse.count).to eq Horse.count
    end
  end

end
