class Movie < ApplicationRecord
  has_many :shows, dependent: :destroy
  has_one_attached :banner_image
  validates :title, presence: true
end
