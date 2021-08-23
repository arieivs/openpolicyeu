class PolicyMaking < ApplicationRecord
  belongs_to :country
  belongs_to :topic
  belongs_to :ambassador
  has_many :users, through: :user_policy_makings
  has_many :policies
  has_many :policy_making_institutions
  has_many :institutions, through: :policy_making_institutions
  has_many :questions

  validates :content, presence: true
  validates :country, uniqueness: { scope: :topic }

end
