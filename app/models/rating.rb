class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :value, presence: true, numericality: { only_integer: true, in: 1..5 }

  def within_25_percent?
    avg = image.average_rating
    return false unless avg

    (value - avg).abs <= avg * 0.25
  end
end
