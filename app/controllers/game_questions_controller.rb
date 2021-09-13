class GameQuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:select_answer_gamebook]

  def select_answer_gamebook
    # when the user clicks in one of the answers from the Gamebook
    # for showing if the answer is right or wrong + explanation:
    @game_question = GameQuestion.find(params[:game_question_id])
    @game_answers = GameAnswer.where(game_question: @game_question)
    @selected_answer = GameAnswer.find(params[:game_answer_id])
    # for showing next question:
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @game_questions = GameQuestion.where(policy_plan: @policy_plan)
    @game_questions = @policy_plan.strategy ? @game_questions.order(:order) : @game_questions.order(:date)
    @game_question_index = params[:game_question_index].to_i + 1
    @next_question = @game_questions[@game_question_index]
    @next_answers = GameAnswer.where(game_question: @next_question)
    if @next_question.nil?
      render :select_answer_last_question_gamebook
    else
      render :select_answer_next_question_gamebook
    end
    # then it renders game_questions > select_answer_gamebook.js.erb automatically
  end
end
