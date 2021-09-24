class Ambassador < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
end
