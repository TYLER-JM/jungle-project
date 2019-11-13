class Admin::ProductsController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  # http_basic_authenticate_with name: "jungle", password: "book"
  
  # before_filter :authenticate
  
  # def authenticate
  #   authenticate_or_request_with_http_basic('Administration') do |username, password|
  #     username == "jungle" && password == "book"
  #     # username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  #   end
  # end
  
  
  def index
    # @dunno  = authenticate
    # @dunno = authenticate_with_http_basic do |name, password|
    #     name == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    #   end
    # puts "DUNNO WHAT"
    # puts @dunno
    # request_http_basic_authentication
    # if self.authenticate
    #   @products = Product.order(id: :desc).all
    # else
    #   redirect_to [:root]
    # end


    # if authenticate_with_http_basic do |name, password|
    #   name == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    # end
    #   @products = Product.order(id: :desc).all
    # else
    #   redirect_to [:root]
    # end

    @products = Product.order(id: :desc).all

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
