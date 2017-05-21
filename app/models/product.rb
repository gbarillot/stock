class Product < ApplicationRecord

  validates_presence_of :name, :reference, :position, :quantity

  after_save :generate_position

private
  def generate_position
    position.split('').each_with_index do |f, i|
      pos = Position.where(['depth = ? AND name = ?', i, f]).last
      if pos
        pos.update_attribute(:quantity, pos.quantity + quantity)
      else
        Position.create!(name: f, depth: i, quantity: quantity)
      end
    end
  end

end
