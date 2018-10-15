class CartsController < ApplicationController
  def show
  end

  def add_to_cart
    @product = Product.find_by(id: params[:product_id])
    @cart = Cart.find_or_create_by(id: params[:cart_id])
    @cart.add_to_cart(@product, parmas[:count])
    render '/'
  end
end
