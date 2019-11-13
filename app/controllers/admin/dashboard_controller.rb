class Admin::DashboardController < ApplicationController
  def show
    @category_count = Category.count
    @product_count = Product.count
    @total = 0
    @all_products = Product.all.each do |item|
      @total += item.quantity
    end
  end
end
