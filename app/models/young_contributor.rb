class YoungContributor < ApplicationRecord
  belongs_to :policy_plan
  has_one_attached :logo

  validates :name, presence: true
  validates :description, presence: true
  validates :website_url, presence: true
end
