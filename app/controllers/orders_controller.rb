class OrdersController < ApplicationController
  def new
    if authorized_user
      @order = Order.new(user_id: params[:user_id])
      @user = @order.user
      @products = Product.all
    else
      return head(:forbidden)
      redirect_to root_path
    end
  end

  def create
    raise order_params.inspect
  end

  def edit
    if authorized_user
      find_order
    else
      return head(:forbidden)
    end
  end

  def index
    if authorized_user
      @orders = Order.where(user_id: params[:user_id])
    elsif admin_user?
      @orders = Order.all
    else
      redirect_to '/'
    end
  end

  def show
    if authorized_user || admin_user
      @order = Order.find_by(id: params[:id])
    else
      return head(:forbidden)
      redirect_to '/'
    end
  end

  def delete
    if authorized_user || admin_user
      find_order
    else
      redirect_to '/'
    end
  end

  private

  def authorized_user
    if session[:user_id] == params[:user_id].to_i
      @user = User.find_by(id: params[:user_id])
    end
  end

  def find_order
    @order = Order.find_by(id: params[:id])
  end

  def order_params
    params.require(:order)
  end

  def create_order(order_params)
    count_array = order_params[:count].delete_if {|a| a == "0"} #[1, 2]
    product_id_array = order_params[:product_id].map {|a| a.to_i} #[1, 3]
    items_array = product_id_array.zip(count_array)
    items_array.each do |array|
      array[1].times do
        Item.create(product_id: array[0], order_id: order_params[:order_id])
      end
    end
  end

  #<ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"caGBthbr+ihIdBi1l5UBhfl6Ax6q4AGHMEoi0qlTPJmdC4YTlYmUcSqOZx+XZuVoqBSKIx0cikOWyFzgmtWhqQ==",
  #"order"=>{"product"=>{"user_id"=>"2"}, "product_id"=>["1", "3"], "count"=>["1", "0", "2", "0", "0", "0", "0"]},
  #"commit"=>"Create Order", "controller"=>"orders", "action"=>"create", "user_id"=>"2"} permitted: false>




end
