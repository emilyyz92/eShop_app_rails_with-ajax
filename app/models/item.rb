class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order, optional: true
  belongs_to :cart, optional: true

  def price
    product.price
  end
end
