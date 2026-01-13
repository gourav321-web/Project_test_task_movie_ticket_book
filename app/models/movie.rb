class Movie < ApplicationRecord
  has_many :shows, dependent: :destroy
  has_one_attached :banner_image
  validates :title, presence: true
  validates :description, presence: true
  validates :duration, presence: true

  before_save :capitalize_fields

   private

  def capitalize_fields
    self.title = title.capitalize if title.present?
    self.description = description.capitalize if description.present?
  end
end
