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


  private

  def product_params
    params.require(:product).permit(:name, :inventory, :price)
  end
end
