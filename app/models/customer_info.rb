class CustomerInfo < ApplicationRecord
  belongs_to :user, optional: true
end
