class GameQuestion < ApplicationRecord
  belongs_to :policy_plan
  has_many :game_answers, dependent: :destroy

  validates :name, presence: true
  validates :context, presence: true
  validates :question, presence: true
end
