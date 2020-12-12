class CustomerInfo < ApplicationRecord
  belongs_to :user, optional: true
  has_many :baskets
end
