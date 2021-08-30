class PolicyMakingInstitution < ApplicationRecord
  belongs_to :policy_making
  belongs_to :institution

  validates :description, presence: true
end
