class PolicyMakingInstitution < ApplicationRecord
  belongs_to :policy_making
  belongs_to :institution

  validates :description, presence: true
  validates :policy_making, uniqueness: { scope: :institution }
end
