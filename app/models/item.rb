class Item < ApplicationRecord
  # The intermediary table between basket and product
  belongs_to :basket
  belongs_to :product
end
