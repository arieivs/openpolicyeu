class Ambassador < ApplicationRecord
  has_many :visual_contents

  validates :name, presence: true
end
