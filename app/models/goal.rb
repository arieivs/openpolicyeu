class Goal < ApplicationRecord
  belongs_to :policy_plan

  validates :name, presence: true
  validates :description, presence: true
  validates :order, presence: true
end
