class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :cart

  def price
    product.price
  end
end
