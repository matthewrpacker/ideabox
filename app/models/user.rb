class User < ActiveRecord::Base
  has_secure_password

  has_many :ideas
  # validates :name, uniqueness: true
end
