class CustomerInfo < ApplicationRecord
  belongs_to :user, optional: true
  has_many :baskets

  validates :customerName, presence: true
  validates :telephone, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :county, presence: true
  validates :postcode, presence: true
end
