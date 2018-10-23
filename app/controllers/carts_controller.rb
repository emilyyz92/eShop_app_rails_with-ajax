class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_cart, only: [:show, :update, :place_order]


  def show
    render json: @cart
  end

  def create
    @product = Product.find_by(id: params[:product_id].to_i)
    @cart = Cart.create
    @cart.user = User.find_by(id: params[:user_id].to_i) if params[:user_id]
    @cart.add_to_cart(@product.id, params[:count])
    render json: @cart
  end

  def update
    @cart.add_to_cart(params[:product_id].to_i, params[:count])
    render json: @cart
  end

  def place_order
    @order = @cart.place_order
    redirect_to order_path(@order)
  end

  def index
    if params[:user_id]
      @carts = Cart.find_by(user_id: params[:user_id].to_i)
    else
      @carts = Cart.all
    end
    render json: @carts
  end


  private

  def find_cart
    @cart = Cart.find_by(id: params[:id])
  end


end
