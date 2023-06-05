require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    @category = Category.new(name: 'catInfo')
    @category.save
  end

  describe 'Validations' do
    it 'should save product when all four required fields are set' do
      @product = Product.new(name: 'silver torch', price: 2780, quantity: 13, category: @category)
      @product.save
      expect(@product.valid?).to be true
    end

    it 'should provide an error message if name is not set' do
      @product = Product.new(name: nil, price: 2780, quantity: 13, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should provide an error message if price is not set' do
      @product = Product.new(name: 'silver torch', quantity: 13, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should provide an error message if quantity is not set' do
      @product = Product.new(name: 'silver torch', price: 2780, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should provide an error message if category is not set' do
      @product = Product.new(name: 'silver torch', price: 2780, quantity: 13, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
