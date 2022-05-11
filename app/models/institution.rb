class Institution < ApplicationRecord
  belongs_to :country
  has_many :policy_making_institutions, dependent: :destroy
  has_many :policy_makings, through: :policy_making_institutions
  has_one_attached :logo

  validates :name, presence: true
  validates :website_url, presence: true
  validates :logo, presence: true
  validates :video_url, format: { with: URI::regexp(%w[http https]) }
end
