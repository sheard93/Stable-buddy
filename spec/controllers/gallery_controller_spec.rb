require 'rails_helper'

RSpec.describe GalleryController, type: :controller do
  describe "gallery#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  


end
