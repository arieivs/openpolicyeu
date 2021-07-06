class CreatePolicyMakingInstitutions < ActiveRecord::Migration[6.1]
  def change
    create_table :policy_making_institutions do |t|
      t.references :policy_making, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
