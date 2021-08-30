class Institution < ApplicationRecord
  belongs_to :country
  has_many :policy_making_institutions
  has_many :policy_makings, through: :policy_making_institutions

  has_one_attached :logo

  validates :name, presence: true
  validates :website_url, presence: true
end
