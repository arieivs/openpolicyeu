class AddDateToGameQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :game_questions, :date, :date
  end
end
