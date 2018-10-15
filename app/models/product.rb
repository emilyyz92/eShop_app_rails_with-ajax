class Product < ApplicationRecord
  has_many :items
  has_many :orders, through: :items

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: {greater_than: 0}
  validates :price, presence: true
  validates :inventory, presence: true

  def availability
    if inventory > 0
      return "Available"
    else
      return "Temporarily Unavailable"
    end
  end
end
