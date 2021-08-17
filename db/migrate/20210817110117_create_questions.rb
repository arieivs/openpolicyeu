class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :policy_making, null: false, foreign_key: true
      t.string :scope
      t.string :question

      t.timestamps
    end
  end
end
