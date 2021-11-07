class VolunteerPosition < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :team, presence: true, inclusion: { in: ["policy", "dev", "comms", "ambassadors", "partners"] }
end
