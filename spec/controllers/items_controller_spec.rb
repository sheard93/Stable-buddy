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
      response_ids = response_value.collect do |item|
        item["id"]
      end
      expect(response_ids).to eq([item1.id, item2.id])
    end
  end

  describe "items#update" do
    it "should allow items to be marked as done" do
      item = FactoryBot.create(:item, done: false)
      put :update, params: {id: item.id, item: { done: true } }
      expect(response).to have_http_status(:success)
      item.reload
      expect(item.done).to eq(true)
    end
  end

  describe "items#create" do
    it "should allow new items to be created" do
      post :create, params: {item: {title: "Order things"} }
      expect(response).to have_http_status(:success)
      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value['title']).to eq("Order things")
      expect(Item.last.title).to eq("Order things")
    end
  end





end
