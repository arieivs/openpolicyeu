class CreateYoungContributors < ActiveRecord::Migration[6.1]
  def change
    create_table :young_contributors do |t|
      t.string :name
      t.string :how_contributed
      t.string :linkedin_link
      t.references :policy_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
