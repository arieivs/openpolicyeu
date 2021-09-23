class CreateGameQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :game_questions do |t|
      t.integer :order
      t.string :name
      t.string :context
      t.string :question
      t.references :policy_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
