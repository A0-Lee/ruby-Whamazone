class Basket < ApplicationRecord
  has_many :items, dependent: :destroy
end
