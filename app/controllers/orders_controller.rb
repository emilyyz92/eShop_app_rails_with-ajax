class OrdersController < ApplicationController
  def new
    if authorized_user
      @order = Order.new(user_id: params[:user_id])
      @user = @order.user
      @products = Product.all
    else
      flash[:error] = "Sorry, you don't have access"
      redirect_to '/'
    end
  end

  def create
    @order = Order.create(user_id: order_params[:user_id])
    create_order(order_params)
    redirect_to user_path(@order.user)
  end

  def edit
    if authorized_user || admin_user
      find_order
      @products = Product.all
    else
      flash[:error] = head(:forbidden)
      redirect_to '/'
    end
  end

  def update
    find_order
    create_order(order_params)
    redirect_to user_order_path(@order.user, @order)
  end

  def index
    if authorized_user
      @user = authorized_user
      @orders = @user.orders
    elsif admin_user
      @orders = Order.all
    else
      flash[:error] = "You don't have access to this page."
      redirect_to '/'
    end
  end

  def show
    if authorized_user || admin_user
      find_order
      redirect_to '/' if !find_order
      @products = @order.uniq_product
      respond_to do |format|
        format.json {render json: @order}
        format.html {render :show}
      end
    else
      redirect_to '/'
    end
  end

  def destroy
    find_order
    Order.delete(@order)
    flash[:message] = "Order successfully deleted."
    redirect_to user_path(current_user)
  end

  def fulfill_order
    find_order
    @order.fulfilled_status = true
    @order.save
    redirect_to orders_path
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
    initial_count_array = order_params[:count].map{|a| a.to_i }
    product_id_array = order_params[:product_id].map {|a| a.to_i} #[1, 3]
    count_array = product_id_array.map {|id| initial_count_array[id - 1]}
    @order.order_create(product_id_array, count_array)
  end

  #<ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"caGBthbr+ihIdBi1l5UBhfl6Ax6q4AGHMEoi0qlTPJmdC4YTlYmUcSqOZx+XZuVoqBSKIx0cikOWyFzgmtWhqQ==",
  #"order"=>{"product"=>{"user_id"=>"2"}, "product_id"=>["1", "3"], "count"=>["1", "0", "2", "0", "0", "0", "0"]},
  #"commit"=>"Create Order", "controller"=>"orders", "action"=>"create", "user_id"=>"2"} permitted: false>




end
