class PhotosController < ApplicationController
  # Checks to see if the user is logged in before running any of this
  before_action :authenticate_user!
  def create
    @place =Place.find(params[:place_id])
    @place.photos.create(photo_params)
    redirect_to place_path(@place)
  end 

  private

  def photo_params
    params.require(:photo).permit(:caption, :picture)
  end
end
