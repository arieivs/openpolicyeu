class CreatePolicies < ActiveRecord::Migration[6.1]
  def change
    create_table :policies do |t|
      t.references :policy_making, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :content
      t.string :policy_plan

      t.timestamps
    end
  end
end
