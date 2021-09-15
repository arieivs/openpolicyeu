class CreateOrganisationCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :organisation_countries do |t|
      t.references :organisation, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
