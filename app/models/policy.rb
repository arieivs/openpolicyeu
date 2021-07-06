class Policy < ApplicationRecord
  belongs_to :policy_making
  belongs_to :category

  validates :name, presence: true
  validates :content, presence: true
  validates :policy_plan, presence: true
end
