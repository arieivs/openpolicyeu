class Topic < ApplicationRecord
  has_many :policy_makings, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :organisation_topics, dependent: :destroy
  has_many :organisations, through: :organisation_topics
  validates :name, presence: true
  validates :icon, presence: true
  validates :icon_color, presence: true

  def to_s
    name
  end
end
