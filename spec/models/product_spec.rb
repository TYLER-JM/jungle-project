require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should create a new product when all fields are present' do
      @category = Category.new(name: "great")
      @category.save!
      @product = Product.new(name: "name", price: 1000, quantity: 3, category: @category)
      @product.save!
      expect(@product.id).to be_present
    end

    it 'should not save when name field is empty' do
      @category = Category.new(name: "great")
      @category.save!
      @product = Product.new(name: nil, price: 1000, quantity: 3, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when price field is empty' do
      @category = Category.new(name: "great")
      @category.save!
      @product = Product.new(name: "boat", price: nil, quantity: 3, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when quantity field is empty' do
      @category = Category.new(name: "great")
      @category.save!
      @product = Product.new(name: "boat", price: 10000, quantity: nil, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not save when category field is empty' do
      @product = Product.new(name: "boat", price: 10000, quantity: 3, category: nil)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
