class OrganisationTopic < ApplicationRecord
  belongs_to :organisation
  belongs_to :topic
end
