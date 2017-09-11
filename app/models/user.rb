class User < ApplicationRecord

  devise :database_authenticatable, :trackable, :validatable

  validates_presence_of :first_name, :last_name
  validates_confirmation_of :password

  has_many :histories
  has_many :orders

  before_save :normalize_names

  def full_name
    "#{first_name} #{last_name}"
  end

private
  def normalize_names
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

end
