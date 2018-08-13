module OrdersHelper

  def created_at(order)
    order.created_at.strftime("Created on %m/%d/%Y")
  end

end
