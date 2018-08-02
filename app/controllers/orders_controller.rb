class OrdersController < ApplicationController
  def new
    @order = Order.new(user_id: params[:user_id])
  end
end
