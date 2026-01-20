class User < ApplicationRecord
  has_secure_password

  has_many :bookings, dependent: :destroy
  has_one_attached :profile_picture

  enum :role,  {user: 0, admin: 1}, default: 0

  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/,  message: "must have 1 capital letter and 1 number"}, allow_nil: true
end
