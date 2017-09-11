class Product < ApplicationRecord

  validates_presence_of :reference, :quantity

  has_many :positions

  def self.autocomplete(q)
    if q.blank?
      out = []
    else
      out = Product.where(['reference ILIKE ?', "#{q}%"]).limit(20)
    end

    return out
  end

end
