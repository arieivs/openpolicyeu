class ChangeRightInAnswers < ActiveRecord::Migration[6.1]
  def change
    change_column :answers, :right, :boolean, default: false
    change_column :game_answers, :right, :boolean, default: false
  end
end
