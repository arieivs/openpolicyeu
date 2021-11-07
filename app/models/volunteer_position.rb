class VolunteerPosition < ApplicationRecord
  belongs_to :team

  validates :name, presence: true
  validates :description, presence: true
  validates :team, presence: true, inclusion: { in: ["policy", "dev", "comms", "ambassadors", "partners"] }
end
