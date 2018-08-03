class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def price
    product.price
  end
end
