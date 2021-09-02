class Topic < ApplicationRecord
  has_many :policy_makings
  has_many :categories
  validates :name, presence: true
  validates :icon, presence: true
  validates :icon_color, presence: true
end
