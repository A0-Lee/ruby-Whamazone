class Order < ApplicationRecord
  belongs_to :basket

  validates :card_number, presence: true
  validates :svc_number, presence: true
end
