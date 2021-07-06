class Topic < ApplicationRecord
  has_many :policy_makings
  has_many :categories
  validates :name, presence: true
end
