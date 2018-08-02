class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, length: {is: 10}
  validates :password, length: {minimum: 2, maximum: 50}

  has_many :items
  has_many :orders
  has_many :products, through: :items
end
