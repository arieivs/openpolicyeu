class OrganisationCountry < ApplicationRecord
  belongs_to :organisation
  belongs_to :country
end
