class Basket < ApplicationRecord

  belongs_to :order
  belongs_to :position 

end
