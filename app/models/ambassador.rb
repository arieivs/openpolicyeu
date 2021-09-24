class Ambassador < ApplicationRecord
  has_many :visual_contents, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
end
