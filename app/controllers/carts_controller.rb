class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
  end

  def create
    @product = Product.find_by(id: params[:product_id].to_i)
    @cart = Cart.find_or_create_by(user_id: params[:user_id].to_i)
    binding.pry
    @cart.add_to_cart(@product.id, params[:count])
    render '/'
  end


end
