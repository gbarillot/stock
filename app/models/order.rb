class Order < ApplicationRecord

  belongs_to :user

  has_many :baskets
  has_many :positions, through: :baskets

  def state_klass
    out = "btn-warning"
    out = 'btn-primary' if state == "done"
    out = 'btn-success' if state == "delivered"

    return out
  end

  def self.waiting_for(user)
    user.orders.where(['state = ?', 'busy'])
  end

end
