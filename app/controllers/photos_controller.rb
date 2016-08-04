class PhotosController < ApplicationController
  # Checks to see if the user is logged in before running any of this
  before_action :authenticate_user!
  def create
    @place =Place.find(params[:place_id])
    if @place.user != current_user
      return render text: "Not Allowed", status: :forbidden
    end

    @photo = @place.photos.build(photo_params)

    if @photo.save
      flash[:notice] = "You did it!!!!!"
    else
      flash[:error] = ""
    end 

    redirect_to place_path(@place)
  end 

  private

  def photo_params
    params.require(:photo).permit(:caption, :picture)
  end
end
