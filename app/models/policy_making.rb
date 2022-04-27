class PolicyMaking < ApplicationRecord
  belongs_to :country
  belongs_to :topic
  has_many :users, through: :user_policy_makings
  has_many :policies, dependent: :destroy
  has_many :policy_making_institutions, dependent: :destroy
  has_many :institutions, through: :policy_making_institutions
  has_many :questions, dependent: :destroy
  has_many :policy_plans

  validates :content, presence: true
  validates :country, uniqueness: { scope: :topic }
  # validates :video_url, url: true

  def question(scope)
    questions.find_by(scope: scope)
  end

  def to_s
    "#{topic} Policymaking in #{country.name == 'European Union' ? 'the ' : ''}#{country}"
  end
end
