class Answer < ApplicationRecord
  belongs_to :question
  validates :answer, presence: true
  validates :right, presence: true
end
