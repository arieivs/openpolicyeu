class PolicyPlanInstitution < ApplicationRecord
  belongs_to :policy_plan
  belongs_to :institution

  validates :description, presence: true
  validates :institution_id, uniqueness: true
end
