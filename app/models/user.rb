class User < ApplicationRecord
  has_secure_password

  has_many :bookings, dependent: :destroy

  has_one_attached :profile_picture

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
