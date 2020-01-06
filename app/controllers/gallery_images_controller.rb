class GalleryImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @gallery_images = GalleryImage.all
  end

  def new
    @gallery_images = GalleryImage.new
  end
  
 def create
    @gallery_images = current_user.gallery_images.create(gallery_params)
    if @gallery_images.valid?
      redirect_to gallery_images_path(@gallery_images)
    else
      render "gallery_images/new", status: :unprocessable_entity
    end
  end

  private

  def gallery_params
    params.require(:gallery_image).permit(:image)
  end
   



end
