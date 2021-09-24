class Opportunity < ApplicationRecord
  belongs_to :organisation
  belongs_to :opportunity_type

  validates :opportunity_type, presence: true
end
