class Product < ApplicationRecord
  has_many :items
  has_many :orders, through: :items
  has_many :users, through: :items

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: {greater_than: 0}
  validates :price, presence: true
  validates :inventory, presence: true
end
