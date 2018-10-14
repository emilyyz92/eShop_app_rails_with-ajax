class ProductsController < ApplicationController
  def new
    if admin_user
      @product = Product.new
    else
      redirect_to '/'
    end
  end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
    find_product
  end

  def index
    @products = Product.all
    respond_to do |format|
      format.json {render json: @products}
      format.html {render :index}
    end
  end

  def destroy
    find_product.delete
    redirect_to products_path
  end

  def edit
    if admin_user
      find_product
    else
      flash[:error] = "Sorry, you don't have access"
      redirect_to '/'
    end
  end

  def update
    find_product.update(product_params) if admin_user
    redirect_to product_path(@product)
  end


  private

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :inventory, :price)
  end
end
