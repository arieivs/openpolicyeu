class Category < ApplicationRecord
  belongs_to :topic
  has_many :policies

  validates :name, presence: true
end
