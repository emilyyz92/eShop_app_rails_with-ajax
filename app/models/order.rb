class Order < ApplicationRecord
  has_many :items
  has_many :products, through: :items
  belongs_to :user
  after_save :product_inventory_update
  attr_accessor :uniq_produdct

  def total_price
    total = 0
    items.each {|item| total += item.price}
    total
  end


  def item_product_count(product)
    items.select{|item| item.product == product}.count
  end

  def order_update(product_id_array, count_array) #method for when order is created in the new order form
    items_array = product_id_array.zip(count_array) #[[product id_1, product_count_1], [product_id_2, product_count_2]]
    items_array.each do |array|
      array[1].times do
        Item.create(product_id: array[0], order_id: self.id)
      end
    end
    self.uniq_produdct = product_id_array
    self.save
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
