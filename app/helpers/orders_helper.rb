module OrdersHelper
  def created_at(order)
    order.created_at.strftime("Created on %m/%d/%Y")
  end

  def find_product(product_id)
    @product = Product.find_by(id: product_id)
  end

  def find_product_name(product_id)
    @product = Product.find_by(id: product_id)
    @product.name
  end
end
