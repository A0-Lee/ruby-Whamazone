class User < ApplicationRecord
  # Encrypt password using hash algorithm
  has_secure_password
  validates_uniqueness_of :username, :email
end
