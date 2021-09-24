class Category < ApplicationRecord
  belongs_to :topic
  has_many :policies, dependent: :destroy

  validates :name, presence: true
end
