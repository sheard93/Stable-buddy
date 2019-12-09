require 'rails_helper'

RSpec.describe HorsesController, type: :controller do
  describe "horses#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "horses#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "horses#create action" do
    it "should successfully create a new horse in the database" do
      post :create, params: { horse: { name: "Hello!" } }
      expect(response).to redirect_to root_path
      horse = Horse.last
      expect(horse.name).to eq("Hello!")
    end
  end

end
