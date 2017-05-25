class Product < ApplicationRecord

  has_many :positions
  validates_presence_of :reference, :quantity

  def self.autocomplete(q)
    Product.where(['reference ILIKE ?', "#{q}%"])
  end
  
end
