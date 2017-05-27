class User < ApplicationRecord

  devise :database_authenticatable, :trackable
  has_many :histories
  has_many :orders

  def full_name
    "#{first_name} #{last_name}"
  end

end
