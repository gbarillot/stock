class Product < ApplicationRecord

  validates_presence_of :name, :reference, :position, :quantity
  validates :quantity, numericality: { only_integer: true }
  after_save :generate_position

  def self.search(q)
    if q.blank?
      out = Product.all.order('created_at DESC')
    else
      if q.first == '#'
        q.slice!(0)
        out = Product.where("position LIKE (?)", "#{q}%")
      else
        out = Product.where("reference ILIKE (?)", "#{q}%")
      end
    end

    return out
  end

private
  def generate_position
    position.split('-').each_with_index do |f, i|
      pos = Position.where(['depth = ? AND name = ?', i, f]).last
      if pos
        pos.update_attribute(:quantity, pos.quantity + quantity)
      else
        Position.create!(name: f, depth: i, quantity: quantity)
      end
    end
  end

end
