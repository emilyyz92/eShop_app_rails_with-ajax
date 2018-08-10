class Order < ApplicationRecord
  has_many :items
  has_many :products, through: :items
  belongs_to :user
  after_save :product_inventory_update

  def total_price
    total = 0
    items.each {|item| total += item.price}
    total
  end


  def product_count(product)
    items.select{|item| item.product == product}.count
  end

  private

  #update inventory count after order is placed
  def product_inventory_update
    products.each do |product|
      product.inventory -= product_count(product)
      product.save
    end
  end


end
