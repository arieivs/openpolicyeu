class PolicyPlanInstitution < ApplicationRecord
  belongs_to :policy_plan
  belongs_to :institution
end
