class Answer < ApplicationRecord
  belongs_to :question
  validates :answer, presence: true
  validates :explanation, presence: true
  validates :right, inclusion: { in: [true, false] }
end
