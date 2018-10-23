class Cart < Order
  belongs_to :user, optional: true
  has_many :items
  has_many :products, through: :items

  def add_to_cart(product_id, count)
    count = count.to_i
    count.times do
      item = Item.create(product_id: product_id, cart_id: self.id)
      self.items << item
    end
    self.save
  end

  def place_order
    order = Order.new(user_id: self.user_id)
    order.items << self.items
    order.save
    self.destroy
    order
  end
end
