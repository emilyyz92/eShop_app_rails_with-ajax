class Order < ApplicationRecord
  has_many :items
  has_many :products, through: :items
  belongs_to :user

  def order_total
  end
end
