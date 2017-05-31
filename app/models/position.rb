class Position < ApplicationRecord

  belongs_to :product, optional: true

  validates_presence_of :name, :level, :quantity
  validates :quantity, numericality: { only_integer: true }
  has_many :baskets
  has_many :orders, through: :baskets

  def self.autocomplete(q)
    if q.blank?
      out = Position.all.order('created_at DESC')
    else
      if q.first == '#'
        q.slice!(0)
        out = Position.where("name LIKE (?)", "#{q}%").limit(20)
      else
        if q == ''
          out = []
        else
          out = Position.joins(:product).where("products.reference ILIKE (?) AND products.id != 0", "#{q}%").limit(20)
        end
      end
    end

    return out
  end

  def self.get(name)
    Position.where(['name = ? AND product_id IS NOT NULL', name]).last
  end

  def insert(params)
    ActiveRecord::Base.transaction do
      prod = Product.find_by(id: params[:product_id])
      if !prod
        errors.add(:product, 'must exist')
        return self
      end

      if free > params[:quantity].to_i
        places = []
        name.split(' ').each_with_index do |f, i|
          places.push(f)
          pos = Position.where(['name = ? AND level = ?', places.join(' '), i]).last
          pos.update_attributes(pos.add_quantities(params))
        end

        History.create!(user_id: $current_user.id, item_type: "Position", item_id: id, actions: {add: params[:quantity], product_id: params[:product_id].to_i})
      else
        errors.add(:name, 'Pas de place')
      end

      return self.reload
    end
  end

  def pick(items)
    ActiveRecord::Base.transaction do
      if items > quantity
        self.errors.add(:quantity, "can't be greater")
        return self
      end

      places = []
      name.split(' ').each_with_index do |f, i|
        places.push(f)
        pos = Position.where(['name = ? AND level = ?', places.join(' '), i]).last
        pos.update_attributes(pos.remove_quantities(items.to_i))
      end

      History.create!(user_id: $current_user.id, item_type: "Position", item_id: id, actions: {remove: items, product_id: product_id})

      return self.reload
    end
  end

  def move(params)
    ActiveRecord::Base.transaction do
      original_product_id = product_id
      pick(params[:quantity])
      Position.find(params[:to]).insert(
        quantity: params[:quantity],
        product_id: original_product_id
      )

      return self
    end
  end

  def add_quantities(args)
    out = {
      quantity: (quantity.to_i + args[:quantity].to_i),
      free: (free.to_i - args[:quantity].to_i),
    }

    out.update(product_id: args[:product_id]) if product_id

    return out
  end

  def remove_quantities(qty)
    out = {
      quantity: (quantity.to_i - qty.to_i),
      free: (free.to_i + qty.to_i),
    }

    out.update(product_id: 0) if (quantity.to_i - qty.to_i) <= 0

    return out
  end

  def self.availabilities(params)
    pos = Position.find(params[:id])
    Position.where([
      'free >= ?
      AND product_id IS NOT NULL
      AND positions.id != ?',
      params[:quantity], pos.id
    ]).limit(50)
  end

  def product
    association(:product).load_target || NullProduct
  end
end
