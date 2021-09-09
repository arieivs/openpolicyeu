class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :name
      t.string :description
      t.references :policy_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
