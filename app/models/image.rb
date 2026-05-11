class Image < ApplicationRecord
  belongs_to :theme
  has_many :ratings
  has_many :users, through: :ratings

  def average_rating
    ratings.average(:value)&.round(2)
  end
end
