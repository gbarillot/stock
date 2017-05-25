class User < ApplicationRecord

  devise :database_authenticatable, :trackable

end
