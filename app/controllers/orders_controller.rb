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
    raise params.inspect
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
    params.require(:product)
  end



end
