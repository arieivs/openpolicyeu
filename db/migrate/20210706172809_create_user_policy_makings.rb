class CreateUserPolicyMakings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_policy_makings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :policy_making, null: false, foreign_key: true

      t.timestamps
    end
  end
end
