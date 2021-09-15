class Opportunity < ApplicationRecord
  belongs_to :organisation

  validates :type, presence: true
end
