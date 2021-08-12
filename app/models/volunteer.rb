class Volunteer < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :role, presence: true
end
