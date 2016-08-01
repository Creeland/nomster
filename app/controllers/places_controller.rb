class PlacesController < ApplicationController
  # Checks before a certain rails action occurs.
  # In this case it only checks if a user is logged in.
  # You can find these action suffixes using "rake routes" :party_parrot:
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete]

  def index
    @places = Place.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.create(place_params)
    # checks if the place has been validated
    if @place.valid?
      redirect_to root_path
    else 
      # if it hasn't then adds an error message, simple_form helps deal with it. 
      render :new, status: :unprocessable_entity
    end 
  end

  def show
    # Querries the Place database to find a "place" with a certain id and assigns it to @place
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])

    # Forbids users from editing other user's places
    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render text: "Not allowed", status: :forbidden
    end

    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render text: "Not Allowed", status: :forbidden
    end 

    @place.destroy
    redirect_to root_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end


