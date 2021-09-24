class CreateOrganisationTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :organisation_topics do |t|
      t.references :organisation, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
