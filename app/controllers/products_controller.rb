class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    # raise @products.inspect
    # render :index
  end

  def show
    @product = Product.find params[:id]
    # render :json => @product.to_json
  end

end
