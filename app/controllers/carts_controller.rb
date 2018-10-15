class CartsController < ApplicationController
  def show
  end

  def add_to_cart
    @product = Product.find_by(id: params[:product_id])
    render 'carts/'
  end
end
