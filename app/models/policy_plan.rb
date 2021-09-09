class PolicyPlan < ApplicationRecord
  belongs_to :policy_making

  validates :name, presence: true
  validates :content, presence: true
end
