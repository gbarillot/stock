require 'test_helper'

describe Position do

  before do
    @path_1 = Position.create!(name: 'a', level: 0, quantity: 8, product_id: nil, free: 10)
    @rack_1 = Position.create!(name: 'a 1', level: 1, quantity: 6, product_id: nil, free: 8)
    @floor_1 = Position.create!(name: 'a 1 23', level: 2, quantity: 4, product_id: nil, free: 6)
    @position_1 = Position.create!(name: 'a 1 23 4', level: 3, quantity: 2, product_id: 0, free: 5)
    @path_2 = Position.create!(name: 'b', level: 0, quantity: 5, product_id: nil, free: 10)
    @position_2 = Position.create!(name: 'b 1', level: 1, quantity: 3, product_id: 0, free: 8)
  end

  describe "#get" do
    it "returns the position based on its name" do
      position = Position.get('a 1 23 4')

      assert_equal 3, position.level
      assert_equal 0, position.product_id
    end
  end

  describe "#insert" do
    it 'adds a product into a position and update the whole tree' do
      position = Position.get('a 1 23 4')
      position.insert(product_id: products(:product_1).id, quantity: 2)

      pos = Position.find_by(name: 'a 1 23 4')
      assert_equal products(:product_1).id, pos.product_id
      assert_equal 4, pos.quantity
      assert_equal 3, pos.free

      pos = Position.find_by(name: 'a 1 23')
      assert_nil pos.product_id
      assert_equal 6, pos.quantity
      assert_equal 4, pos.free

      pos = Position.find_by(name: 'a 1')
      assert_nil pos.product_id
      assert_equal 8, pos.quantity
      assert_equal 6, pos.free

      pos = Position.find_by(name: 'a')
      assert_nil pos.product_id
      assert_equal 10, pos.quantity
      assert_equal 8, pos.free
    end
  end

  describe "#pick" do
    it 'removes a product from a position and update the whole tree' do
      position = Position.get('a 1 23 4')
      position.insert(product_id: products(:product_1).id, quantity: 2, name: 'a 1 23 4')
      position.pick(1)

      pos = Position.find_by(name: 'a 1 23 4')
      assert_equal products(:product_1).id, pos.product_id
      assert_equal 3, pos.quantity
      assert_equal 4, pos.free

      pos = Position.find_by(name: 'a 1 23')
      assert_nil pos.product_id
      assert_equal 5, pos.quantity
      assert_equal 5, pos.free

      pos = Position.find_by(name: 'a 1')
      assert_nil pos.product_id
      assert_equal 7, pos.quantity
      assert_equal 7, pos.free

      pos = Position.find_by(name: 'a')
      assert_nil pos.product_id
      assert_equal 9, pos.quantity
      assert_equal 9, pos.free
    end

    it "sets product_id to 0(empty) when quantity == 0" do
      @position_1.update_attribute(:quantity, 0)
      position = Position.get('a 1 23 4')
      position.insert(product_id: products(:product_1).id, quantity: 2)
      position.pick(2)

      pos = Position.find_by(name: 'a 1 23 4')
      assert_equal 0, pos.product_id
      assert_equal 0, pos.quantity
      assert_equal 5, pos.free

      pos = Position.find_by(name: 'a 1 23')
      assert_nil pos.product_id
      assert_equal 4, pos.quantity
      assert_equal 6, pos.free

      pos = Position.find_by(name: 'a 1')
      assert_nil pos.product_id
      assert_equal 6, pos.quantity
      assert_equal 8, pos.free

      pos = Position.find_by(name: 'a')
      assert_nil pos.product_id
      assert_equal 8, pos.quantity
      assert_equal 10, pos.free
    end
  end

  describe "#move" do
    it 'moves a product from a position to another one and update the whole tree' do
      position = Position.get('a 1 23 4')
      position.insert(product_id: products(:product_1).id, quantity: 2, name: 'a 1 23 4')
      position.move(quantity: 1, to: @position_2.id)

      pos = Position.find_by(name: 'a 1 23 4')
      assert_equal products(:product_1).id, pos.product_id
      assert_equal 3, pos.quantity
      assert_equal 4, pos.free

      pos = Position.find_by(name: 'a 1 23')
      assert_nil pos.product_id
      assert_equal 5, pos.quantity
      assert_equal 5, pos.free

      pos = Position.find_by(name: 'a 1')
      assert_nil pos.product_id
      assert_equal 7, pos.quantity
      assert_equal 7, pos.free

      pos = Position.find_by(name: 'a')
      assert_nil pos.product_id
      assert_equal 9, pos.quantity
      assert_equal 9, pos.free

      pos = Position.find_by(name: 'b 1')
      assert_equal products(:product_1).id, pos.product_id
      assert_equal 4, pos.quantity
      assert_equal 7, pos.free
    end
  end

end
