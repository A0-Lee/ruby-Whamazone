class Basket < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :customer_info, optional: true
  has_one :order
end
