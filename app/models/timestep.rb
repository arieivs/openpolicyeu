class Timestep < ApplicationRecord
  belongs_to :policy_plan

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
end
