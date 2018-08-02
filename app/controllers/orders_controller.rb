class OrdersController < ApplicationController
  def new
    if order_authorize
      @order = Order.new(user_id: @user.id)
    else
      return head(:forbidden)
    end
  end

  private

  def order_authorize
    if session[:user_id] == params[:user_id]
      @user = User.find_by(id: params[:user_id])
    else
      return nil
    end
  end
end
