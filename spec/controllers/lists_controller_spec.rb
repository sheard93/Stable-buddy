require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  describe "lists#index action" do
    it "should slist the tasks in the database" do
      item1 = FactoryBot.create(:item)
      get :index
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value.count).to eq (1)
    end
  end

  describe "lists#new action" do
    it "should allow users to add items to the list" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


end
