class YoungContributor < ApplicationRecord
  belongs_to :policy_plan
  has_one_attached :photo

  validates :name, presence: true
  validates :how_contributed, presence: true
end
