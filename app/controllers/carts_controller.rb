class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_cart, only: [:show, :update]


  def show
    render json: @cart
  end

  def create
    @product = Product.find_by(id: params[:product_id].to_i)
    @cart = Cart.find_or_create_by(user_id: params[:user_id].to_i)
    @cart.add_to_cart(@product.id, params[:count])
    render json: @cart
  end

  def update
    @cart.add_to_cart(params[:product_id].to_i, params[:count])
    render json: @cart
  end


  private

  def find_cart
    @cart = Cart.find_by(id: params[:id])
  end


end
