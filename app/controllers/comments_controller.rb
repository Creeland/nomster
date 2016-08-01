class CommentsController < ApplicationController
  # Checks to see if the user is logged in before running any of this
  before_action :authenticate_user!
  def create
    @place =Place.find(params[:place_id])
    # Addes the ability to create a comment, also checks the comment params method
    # The current user is also merged into the params hash 
    @place.comments.create(comment_params.merge(user: current_user))
    redirect_to place_path(@place)
  end 

  private

  def comment_params
    params.require(:comment).permit(:message, :rating)
  end
end
