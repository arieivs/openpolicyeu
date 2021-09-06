class Question < ApplicationRecord
  belongs_to :policy_making
  has_many :answers, dependent: :destroy
  validates :question, presence: true
  validates :scope, presence: true, inclusion: {in: ["content", "institutions"]}
end
