class CreatePolicyPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :policy_plans do |t|
      t.string :name
      t.string :content
      t.string :video_url
      t.string :video_alt_text
      t.string :video_source
      t.boolean :strategy, default: false
      t.references :policy_making, null: false, foreign_key: true
      t.references :ambassador, null: true, foreign_key: true

      t.timestamps
    end
  end
end
