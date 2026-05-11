class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :image

  def within_25_percent?
    avg = image.average_rating
    return false unless avg

    (value - avg).abs <= avg * 0.25
  end
end
