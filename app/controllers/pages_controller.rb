class PagesController < ApplicationController
  def main
    @themes = Theme.all

    @theme = if params[:theme_id]
      Theme.find(params[:theme_id])
    else
      Theme.first
    end

    @images = @theme.images

    # индекс текущего изображения
    @index = params[:index].to_i || 0

    @image = @images[@index]

    @ratings = @image ? @image.ratings.includes(:user) : []
  end
end
