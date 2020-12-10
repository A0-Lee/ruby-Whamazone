class Product < ApplicationRecord
  # Ensures the Price field can only be >= £0 - So third-party listings cannot be free
  validates :price, numericality: {greater_than_or_equal_to: 0}
  has_many :items, dependent: :restrict_with_error
  has_many :reviews
end
