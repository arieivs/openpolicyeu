class Country < ApplicationRecord
  has_many :policy_makings, dependent: :destroy
  has_many :organisation_countries, dependent: :destroy
  has_many :organisations, through: :organisation_countries

  has_one_attached :flag

  validates :name, presence: true
end
