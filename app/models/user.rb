class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: {minimum: 2, maximum: 50}, allow_blank: true

  has_many :orders
  has_many :items, through: :orders
  has_many :products, through: :items

  def uniq_products
    products.uniq {|product| product.id}
  end
end
