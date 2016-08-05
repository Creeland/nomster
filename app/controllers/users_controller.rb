class UsersController < ApplicationController

  def show 
    # pulls the id from the url then queries the User table for the current user
    @user = User.find(params[:id])
  end

end
