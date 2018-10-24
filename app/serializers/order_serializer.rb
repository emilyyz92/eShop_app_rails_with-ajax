class OrderSerializer < CartSerializer
  attributes :id, :user_id, :products, :total, :product_with_units, :next_order_id

  def next_order_id
    if object.next_order
      object.next_order.id
    else
      return nil
    end
  end

end
