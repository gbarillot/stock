require 'test_helper'

describe Position do

  before do
    Position.destroy_all
  end

  describe "#link" do
    it 'validations are ok' do
      Position.link(product_id: products(:product_1).id, quantity: 2, name: 'a')

      assert_equal products(:product_1).id, Position.last.product_id
      assert_equal 1, Position.all.count
    end

    it 'validations fail cause already existing product' do
      Position.create!(product_id: products(:product_1).id, quantity: 2, name: 'a')
      out = Position.link(product_id: products(:product_2).id, quantity: 2, name: 'a')

      assert_equal 1, out.errors.messages.count
      assert_equal ["Deja existant"], out.errors.messages[:name]
      assert_equal 1, Position.all.count
    end

    it 'validations fail cause missing product_id' do
      out = Position.link(product_id: '', name: 'name', quantity: 2)

      assert_equal 1, out.errors.count
      assert_equal ["must exist"], out.errors.messages[:product]
      assert_equal 0, Position.all.count
    end

    it 'generates positions tree on product creation' do
      Position.destroy_all
      Position.link(product_id: products(:product_1).id, name: 'a 1 b 2', quantity: 2)

      assert_equal 4, Position.all.length
      assert_equal 'a 1 b 2', Position.last.name
      assert_equal 2, Position.last.quantity
      assert_equal 3, Position.last.depth
    end

    it 'generates positions tree on product complex creation' do
      Position.link(product_id: products(:product_1).id, quantity: 2, name: 'a b 2 5')

      assert_equal 4, Position.all.length
      l1 = Position.where(['depth = ?', 0]).last
      l2 = Position.where(['depth = ?', 1]).last
      l3 = Position.where(['depth = ?', 2]).last
      l4 = Position.where(['depth = ?', 3]).last

      assert_equal 'a', l1.name
      assert_equal 2, l1.quantity

      assert_equal 'a b', l2.name
      assert_equal 2, l2.quantity

      assert_equal 'a b 2', l3.name
      assert_equal 2, l3.quantity

      assert_equal 'a b 2 5', l4.name
      assert_equal 2, l4.quantity
    end

    it 'generates positions tree on existing product tree using complex creation' do
      Position.create!(name: 'a', depth: 0, quantity: 5)
      Position.create!(name: 'a b', depth: 1, quantity: 3)

      Position.link(product_id: products(:product_1).id, quantity: 2, name: 'a b 2 5')

      assert_equal 4, Position.all.length
      l1 = Position.where(['depth = ?', 0]).last
      l2 = Position.where(['depth = ?', 1]).last
      l3 = Position.where(['depth = ?', 2]).last
      l4 = Position.where(['depth = ?', 3]).last

      assert_equal 'a', l1.name
      assert_equal 7, l1.quantity

      assert_equal 'a b', l2.name
      assert_equal 5, l2.quantity

      assert_equal 'a b 2', l3.name
      assert_equal 2, l3.quantity

      assert_equal 'a b 2 5', l4.name
      assert_equal 2, l4.quantity
    end

    it "piles up quantity when same product already on this position" do
      Position.create!(name: 'a', depth: 0, quantity: 5)
      Position.create!(name: 'a b', depth: 1, quantity: 3)

      Position.link(product_id: products(:product_1).id, quantity: 2, name: 'a b 2 5')
      Position.link(product_id: products(:product_1).id, quantity: 2, name: 'a b 2 5')

      assert_equal 4, Position.all.length
      l1 = Position.where(['depth = ?', 0]).last
      l2 = Position.where(['depth = ?', 1]).last
      l3 = Position.where(['depth = ?', 2]).last
      l4 = Position.where(['depth = ?', 3]).last

      assert_equal 'a', l1.name
      assert_equal 9, l1.quantity

      assert_equal 'a b', l2.name
      assert_equal 7, l2.quantity

      assert_equal 'a b 2', l3.name
      assert_equal 4, l3.quantity

      assert_equal 'a b 2 5', l4.name
      assert_equal 4, l4.quantity
    end
  end

end
