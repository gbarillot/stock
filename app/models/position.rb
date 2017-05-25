class Position < ApplicationRecord

  belongs_to :product, optional: true

  validates_presence_of :name, :depth, :quantity
  validates :quantity, numericality: { only_integer: true }

  def self.search(q)
    if q.blank?
      out = Position.all.order('created_at DESC')
    else
      if q.first == '#'
        q.slice!(0)
        out = Position.where("name LIKE (?)", "#{q}%")
      else
        out = Position.joins(:product).where("products.reference ILIKE (?)", "#{q}%")
      end
    end

    return out
  end

  def self.link(params)

    ActiveRecord::Base.transaction do
      new_position = Position.new(params)

      prod = Product.find_by(id: params[:product_id])
      if !prod
        new_position.errors.add(:product, 'must exist')
        return new_position
      end

      existing = Position.where(['name = ? AND quantity > 0', params[:name]])
      if existing.any?
        if existing.last.product_id == params[:product_id].to_i
          places = []
          new_position.name.split(' ').each_with_index do |f, i|
            places.push(f)
            pos = Position.where(['name = ? AND depth = ?', places.join(' '), i]).last
            if pos
              pos.update_attribute(:quantity, pos.quantity.to_i + params[:quantity].to_i)
            else
              existing.update_attribute(quantity: params[:quantity].to_i)
            end
          end
        else
          new_position.errors.add(:name, 'Deja existant')
        end
      else
        if new_position.valid?
          places = []
          new_position.name.split(' ').each_with_index do |f, i|
            places.push(f)
            pos = Position.where(['name = ? AND depth = ?', places.join(' '), i]).last
            if pos
              pos.update_attribute(:quantity, pos.quantity.to_i + params[:quantity].to_i)
            else
              if i == new_position.name.split(' ').size - 1
                new_position = Position.create!(name: places.join(' '), depth: i, quantity: params[:quantity].to_i, product_id: params[:product_id].to_i)
              else
                new_position = Position.create!(name: places.join(' '), depth: i, quantity: params[:quantity].to_i)
              end
            end
          end
        end
      end

      return new_position
    end
  end

  def move(params)
    new_position = Position.new(params)
    existing = Position.where(['position = ? AND quantity > 0', params[:position]])

    if existing.any?
      new_position.errors.add(:position, 'Deja existant')
    else
      if new_position.save
        new_position.name.split(' ').each_with_index do |f, i|
          pos = Position.where(['depth = ? AND name = ?', i, f]).last
          if pos
            pos.update_attribute(:quantity, pos.quantity + new_product.quantity)
          else
            Position.create!(name: f, depth: i, quantity: new_product.quantity)
          end
        end
      end
    end

    return new_product
  end

end
