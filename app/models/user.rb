class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :ratings
  has_many :images, through: :ratings
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
