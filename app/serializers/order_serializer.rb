class OrderSerializer < CartSerializer
  attributes :id, :user_id, :products, :total, :product_with_units, :next_order_id

  def next_order_id
    object.next_order.id
  end

end
