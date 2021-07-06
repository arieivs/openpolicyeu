class CreatePolicyMakings < ActiveRecord::Migration[6.1]
  def change
    create_table :policy_makings do |t|
      t.references :country, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.string :content
      t.string :video_url
      t.string :video_alt_text
      t.string :video_source
      t.references :ambassador, null: true, foreign_key: true

      t.timestamps
    end
  end
end
