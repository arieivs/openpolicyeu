class OpportunityType < ApplicationRecord
  has_many :opportunities, dependent: :destroy
end
