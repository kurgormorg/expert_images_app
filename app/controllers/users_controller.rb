class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @ratings = @user.ratings.includes(:image)

    @good_ratings = @ratings.select(&:within_25_percent?)
  end
end