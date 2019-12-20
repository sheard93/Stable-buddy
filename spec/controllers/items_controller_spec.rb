require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "items#index" do
    it "should list the items in the database" do
      task1 = FactoryBot.create(:item)
      task2 = FactoryBot.create(:item)
      get :index
      expect(response).to have_http_status :success
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value.count).to eq(2)
    end
  end
end
