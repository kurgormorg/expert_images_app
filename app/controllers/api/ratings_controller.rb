class Api::RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    rating = Rating.find_or_initialize_by(
      user: current_user,
      image_id: params[:image_id]
    )

    rating.value = params[:value]
    rating.save!

    render json: {
      success: true,
      average: rating.image.average_rating.to_f,
      user_id: rating.user_id,
      user_email: rating.user.email,
      value: rating.value
    }
  rescue ActiveRecord::RecordInvalid => error
    render json: {
      success: false,
      errors: error.record.errors.full_messages
    }, status: :unprocessable_entity
  end
end
