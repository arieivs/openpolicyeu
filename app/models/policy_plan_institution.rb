class PolicyPlanInstitution < ApplicationRecord
  belongs_to :policy_plan
  belongs_to :institution

  validates :description, presence: true
end
