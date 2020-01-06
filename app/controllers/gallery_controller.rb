class GalleryController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @gallery_images = GalleryImage.all
  end

  def new
    @gallery_images = GalleryImage.new
  end
  
 def create
    @gallery_images = current_user.Gallery.create(gallery_params)
    if @gallery_images.valid?
      redirect_to gallery_index_path(@gallery_images)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def horse_params
    params.require(:gallery_images).permit(:photo)
  end
   



end
