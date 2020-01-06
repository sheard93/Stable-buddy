class GalleryController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @gallery_images = GalleryImage.all
  end

  def new
    @gallery_images = GalleryImage.new
  end
  


end
