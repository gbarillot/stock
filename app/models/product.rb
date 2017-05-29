class Product < ApplicationRecord

  has_many :positions
  validates_presence_of :reference, :quantity

  def self.autocomplete(q)
    if q.blank?
      out = []
    else
      out = Product.where(['reference ILIKE ?', "#{q}%"]).limit(20)
    end

    return out
  end

end
