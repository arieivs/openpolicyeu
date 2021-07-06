class Country < ApplicationRecord
  has_many :policy_makings

  validates :name, presence: true
end
