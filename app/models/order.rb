class Order < ApplicationRecord

  validates_presence_of :reference, :due_at

  has_many :baskets
  has_many :positions, through: :baskets

  belongs_to :user

  def state_klass
    out = "btn-warning"
    out = 'btn-primary' if state == "done"
    out = 'btn-success' if state == "delivered"

    return out
  end

  def self.waiting_for(user)
    user.orders
  end

  def countdown_refs
    out = 0
    f = baskets.where('picked = true').count.to_f
    i = baskets.count.to_f

    if i > 0.0
      out = (((f / i )*100.0).to_i).round(-1)
    end
  end

  def countdown_time
    out = 0
    f = due_at.to_i.to_f - created_at.to_i.to_f
    i = due_at.to_i.to_f - Time.now.to_i.to_f

    out = (100 - ((i / f) *100.0).to_i).round(-1)
  end

end
