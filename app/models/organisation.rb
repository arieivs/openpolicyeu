class Organisation < ApplicationRecord
  has_many :opportunities, dependent: :destroy
  has_many :organisation_countries, dependent: :destroy
  has_many :organisation_topics, dependent: :destroy
  has_many :countries, through: :organisation_countries
  has_many :topics, through: :organisation_topics
  has_many :opportunity_types, through: :opportunities
  has_one_attached :logo


  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :learn_more_link, presence: true

end
