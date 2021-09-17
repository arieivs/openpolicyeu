class CreateGameAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :game_answers do |t|
      t.string :answer
      t.string :explanation
      t.boolean :right
      t.references :game_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
