class User < ApplicationRecord
  # Hash and salt passwords using bcrypt hash algorithm methods
  has_secure_password
  # A user can only have one customer record
  has_one :customer_info
  #validates_uniqueness_of :username, :email
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
