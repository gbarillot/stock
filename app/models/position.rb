class Position < ApplicationRecord

  def self.search(q)
    out = Product.where("position LIKE (?)", "#{q}%")

    return out
  end

end
