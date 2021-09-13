class GameQuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:select_answer_gamebook]

  def select_answer_gamebook
    # when the user clicks in one of the answers from the Gamebook
    # for showing the if the answer is right or wrong + explanation:
    @game_question = GameQuestion.find(params[:game_question_id])
    @game_answers = GameAnswer.where(game_question: @game_question)
    @selected_answer = GameAnswer.find(params[:game_answer_id])
    # for showing next question:
    @game_questions = GameQuestion.where(policy_plan_id: params[:policy_plan_id])
    # @next_question = ?
    # @next_answers = ?
    # then it renders game_questions > select_answer_gamebook.js.erb automatically
  end
end
