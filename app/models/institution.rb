class Institution < ApplicationRecord
  belongs_to :country
  belongs_to :ambassador
  has_many :policy_making_institutions
  has_many :policy_makings, through: :policy_making_institutions

  validates :name, presence: true
  validates :description, presence: true
  validates :website_url, presence: true
end
