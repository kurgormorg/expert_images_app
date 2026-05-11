class PagesController < ApplicationController
  def main
    @themes = Theme.order(:name)
    @theme = params[:theme_id].present? ? Theme.find_by(id: params[:theme_id]) : @themes.first
    @theme ||= @themes.first

    @images = @theme ? @theme.images.order(:id).to_a : []

    if params[:image_id].present?
      @image = @images.find { |image| image.id == params[:image_id].to_i }
      @index = @image ? @images.index(@image) : 0
    else
      @index = params[:index].to_i
      @index = 0 if @index.negative?
      @index = @images.size - 1 if @images.any? && @index >= @images.size
      @image = @images[@index]
    end

    @image ||= @images.first
    @index ||= 0
    @ratings = @image ? @image.ratings.includes(:user) : []
  end
end
