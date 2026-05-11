class Image < ApplicationRecord
  belongs_to :theme
  has_many :ratings
  has_many :users, through: :ratings

  validates :title, :file_path, presence: true
  validates :file_path, uniqueness: { scope: :theme_id }

  def average_rating
    ratings.average(:value)&.round(2)
  end
end
