class GalleryController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @gallery_images = GalleryImage.all
  end

  


end
