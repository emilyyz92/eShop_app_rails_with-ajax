class Order < ApplicationRecord
  has_many :items
  has_many :products, through: :items
  belongs_to :user

  def order_total_price
    total = 0
    items.each {|item| total += item.price}
  end

  def product_inventory_update
    products.each do |product|
      p_count = items.select{|item| item.product == product}.count
      product.inventory -= p_count
      if product.inventory < 0
        "There aren't enough #{product} to order"
      else
        product.save
      end
    end
  end

end
