class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :user

  def price
    product.price
  end
end
