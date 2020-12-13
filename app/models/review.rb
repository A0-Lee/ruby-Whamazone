class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :title, presence: true
  validates :comment, presence: true
  validates :rating, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}, presence: true
end
