class GameQuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:select_answer_gamebook]

  def select_answer_gamebook
    # when the user clicks in one of the answers from the Gamebook
    @game_question = GameQuestion.find(params[:game_question_id])
    @game_answers = GameAnswer.where(game_question: @game_question)
    @selected_answer = GameAnswer.find(params[:game_answer_id])
    # then it renders game_questions > select_answer_gamebook.js.erb automatically
  end
end
