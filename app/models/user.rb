class User < ApplicationRecord

  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable,
  #        :encryptable, :validatable, :omniauthable,
  #        :omniauth_providers => [:facebook], :encryptor => :authlogic_sha512

  devise :database_authenticatable, :trackable, :validatable
  has_many :histories
  has_many :orders

  validates_presence_of :first_name, :last_name
  validates_confirmation_of :password

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
