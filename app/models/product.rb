class Product < ApplicationRecord

  has_many :positions
  validates_presence_of :reference, :quantity

end
