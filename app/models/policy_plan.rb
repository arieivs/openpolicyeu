class PolicyPlan < ApplicationRecord
  belongs_to :policy_making
  has_many :policy_plan_institutions, dependent: :destroy
  has_many :institutions, through: :policy_plan_institutions

  validates :name, presence: true
  validates :content, presence: true
  validates :short_description, presence: true
  validates :goals, inclusion: { in: [true, false] }
  validates :video_url, url: true
end
