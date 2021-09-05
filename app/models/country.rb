class Country < ApplicationRecord
  has_many :policy_makings

  has_one_attached :flag

  validates :name, presence: true
end
