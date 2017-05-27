class Position < ApplicationRecord

  belongs_to :product, optional: true

  validates_presence_of :name, :depth, :quantity
  validates :quantity, numericality: { only_integer: true }
  has_many :baskets
  has_many :orders, through: :baskets

  def self.autocomplete(q)
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

      existing = Position.where(['name = ? AND quantity > 0', params[:name]]).last
      if existing
        if existing.product_id == params[:product_id].to_i
          places = []
          new_position.name.split(' ').each_with_index do |f, i|
            places.push(f)
            pos = Position.where(['name = ? AND depth = ?', places.join(' '), i]).last
            if pos
              pos.update_attributes(quantity: (pos.quantity.to_i + params[:quantity].to_i), free: (pos.free.to_i - params[:quantity].to_i))
            else
              existing.update_attributes(quantity: params[:quantity].to_i, free: (existing.free.to_i - params[:quantity].to_i))
            end
          end
          History.create!(user_id: $current_user.id, item_type: "Position", item_id: existing.id, actions: {add: params[:quantity], product_id: params[:product_id].to_i})
        else
          new_position.errors.add(:name, 'Deja existant')
        end
      else
        if new_position.valid?
          places = []
          position_depth = new_position.name.split(' ').length
          new_position.name.split(' ').each_with_index do |f, i|
            places.push(f)
            pos = Position.where(['name = ? AND depth = ?', places.join(' '), i]).last
            if pos
              pos.update_attributes(quantity: pos.quantity.to_i + params[:quantity].to_i, free: (pos.free.to_i - params[:quantity].to_i))
            else
              if i == position_depth - 1
                new_position = Position.create!(name: places.join(' '), depth: i, quantity: params[:quantity].to_i, product_id: params[:product_id].to_i)
                History.create!(user_id: $current_user.id, item_type: "Position", item_id: new_position.id, actions: {add: params[:quantity], product_id: params[:product_id].to_i})
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

  def unlink(removed_quantity)
    ActiveRecord::Base.transaction do
      if removed_quantity > quantity
        self.errors.add(:quantity, "can't be greater")
        return self
      end

      places = []
      name.split(' ').each_with_index do |f, i|
        places.push(f)
        pos = Position.where(['name = ? AND depth = ?', places.join(' '), i]).last
        pos.update_attribute(:quantity, pos.quantity.to_i - removed_quantity.to_i)
      end

      History.create!(user_id: $current_user.id, item_type: "Position", item_id: id, actions: {remove: removed_quantity, product_id: product_id})

      self.reload
    end
  end

end
