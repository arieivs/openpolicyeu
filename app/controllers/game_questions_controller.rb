class GameQuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:select_answer_gamebook, :select_answer_goal]

  def select_answer_gamebook
    # when the user clicks in one of the answers from the Gamebook
    # for showing if the answer is right or wrong + explanation:
    set_data_for_answer_after
    # for showing next question:
    set_data_for_next_question
    if @next_question.nil?
      render :select_answer_last_question_gamebook
    else
      render :select_answer_next_question_gamebook
    end
    # then it renders game_questions > select_answer_gamebook.js.erb automatically
  end

  def select_answer_goal
    # when the user clicks in one of the answers from the Goals
    set_data_for_answer_after
    # then it renders game_questions > select_answer_goal.js.erb automatically
  end

  private

  def set_data_for_answer_after
    @game_question = GameQuestion.find(params[:game_question_id])
    @game_answers = GameAnswer.where(game_question: @game_question)
    @selected_answer = GameAnswer.find(params[:game_answer_id])
  end

  def set_data_for_next_question
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @game_questions = GameQuestion.where(policy_plan: @policy_plan)
    @game_questions = @policy_plan.strategy ? @game_questions.order(:order) : @game_questions.order(:date)
    @game_question_index = params[:game_question_index].to_i + 1
    @next_question = @game_questions[@game_question_index]
    @next_answers = GameAnswer.where(game_question: @next_question)
  end
end
