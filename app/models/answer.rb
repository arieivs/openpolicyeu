class Answer < ApplicationRecord
  belongs_to :question
  validates :answer, presence: true
  validates :explanation, presence: true
  # not needed because of the default: false :
  # validates :right, inclusion: { in: [true, false] }
end
