class GameAnswer < ApplicationRecord
  belongs_to :game_question
  validates :answer, presence: true
  validates :explanation, presence: true
  # not needed because of the default: false :
  # validates :right, inclusion: { in: [true, false] }
end
