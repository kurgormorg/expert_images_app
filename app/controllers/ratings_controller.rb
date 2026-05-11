class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    rating = Rating.find_or_initialize_by(
    user: current_user,
    image_id: params[:image_id]
  )

  rating.value = params[:value]
  rating.save

    redirect_to root_path(image_id: params[:image_id])
  end
end