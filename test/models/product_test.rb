require 'test_helper'

describe Product do

  before do
    Position.destroy_all
  end

  describe "position tree" do
    it 'generates positions tree on product creation' do
      Product.create(name: 'name', reference: 'ref', quantity: 2, position: 'a')

      assert_equal 1, Position.all.length
      assert_equal 'a', Position.last.name
      assert_equal 2, Position.last.quantity
    end

    it 'generates positions tree on product complex creation' do
      Product.create!(name: 'name', reference: 'ref', quantity: 2, position: 'ab25')

      assert_equal 4, Position.all.length
      l1 = Position.where(['depth = ?', 0]).last
      l2 = Position.where(['depth = ?', 1]).last
      l3 = Position.where(['depth = ?', 2]).last
      l4 = Position.where(['depth = ?', 3]).last

      assert_equal 'a', l1.name
      assert_equal 2, l1.quantity

      assert_equal 'b', l2.name
      assert_equal 2, l2.quantity

      assert_equal '2', l3.name
      assert_equal 2, l3.quantity

      assert_equal '5', l4.name
      assert_equal 2, l4.quantity
    end

    it 'generates positions tree on existing product tree using complex creation' do
      Position.create!(name: 'a', depth: 0, quantity: 5)
      Position.create!(name: 'b', depth: 1, quantity: 3)

      Product.create!(name: 'name', reference: 'ref', quantity: 2, position: 'ab25')

      assert_equal 4, Position.all.length
      l1 = Position.where(['depth = ?', 0]).last
      l2 = Position.where(['depth = ?', 1]).last
      l3 = Position.where(['depth = ?', 2]).last
      l4 = Position.where(['depth = ?', 3]).last

      assert_equal 'a', l1.name
      assert_equal 7, l1.quantity

      assert_equal 'b', l2.name
      assert_equal 5, l2.quantity

      assert_equal '2', l3.name
      assert_equal 2, l3.quantity

      assert_equal '5', l4.name
      assert_equal 2, l4.quantity
    end
  end
end
