class Order < ApplicationRecord
  has_many :items
  has_many :products, through: :items
  belongs_to :user
  after_save :create_items

  def total_price
    total = 0
    items.each {|item| total += item.price}
    total
  end

  #update inventory count after order is placed
  def product_inventory_update
    products.each do |product|
      p_count = items.select{|item| item.product == product}.count
      product.inventory -= p_count
      if product.inventory < 0
        "Sorry, there aren't enough #{product} to order. You can order up to #{product.inventory}"
      else
        product.save
        "Congratulations, your order was submitted."
      end
    end
  end

  def product_count(product)
    items.select{|item| item.product == product}.count
  end

  private
  #create items upon order creation
  def create_items
    products.each do |product|
      product_count(product).times do
        Item.create(order_id: self.id, product_id: product.id)
      end
    end
  end

end
