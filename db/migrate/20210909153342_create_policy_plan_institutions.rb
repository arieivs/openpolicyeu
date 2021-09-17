class CreatePolicyPlanInstitutions < ActiveRecord::Migration[6.1]
  def change
    create_table :policy_plan_institutions do |t|
      t.references :policy_plan, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
