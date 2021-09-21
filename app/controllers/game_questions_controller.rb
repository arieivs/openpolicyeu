class GameQuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:select_answer_gamebook, :select_answer_goal]

  def create
    @game_question = GameQuestion.new(game_question_params)
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @game_question.policy_plan = @policy_plan
    save_successful = @game_question.save
    if @policy_plan.strategy
      @goal = Goal.where(policy_plan: @policy_plan).find_by(order: @game_question.order)
      @game_answers = GameAnswer.where(game_question: @game_question)
      @new_game_question = nil
    else
      set_game_questions
      set_game_answers
      @new_game_question = GameQuestion.new
    end
    @new_game_answer = GameAnswer.new
    if save_successful
      respond_to { |format| format.js }
    else
      @new_game_question = GameQuestion.new
      respond_to { |format| format.js { flash.now[:alert] = "Please add all the required fields to create a question." } }
    end
  end

  def edit
    @game_question = GameQuestion.find(params[:id])
    @policy_plan = @game_question.policy_plan
    respond_to { |format| format.js }
  end

  def update
    @game_question = GameQuestion.find(params[:id])
    @policy_plan = @game_question.policy_plan
    if @game_question.update(game_question_params)
      respond_to { |format| format.js }
    else
      render :edit
    end
  end

  def destroy
    @game_question = GameQuestion.find(params[:id])
    @policy_plan = @game_question.policy_plan
    # for goals/strategy
    if @policy_plan.strategy
      @goal = Goal.where(policy_plan: @policy_plan).find_by(order: @game_question.order)
      @new_game_question = GameQuestion.new
    end
    @game_question.destroy
    # for gamebook/policy plan
    set_game_questions
    set_game_answers
    @new_game_answer = GameAnswer.new
    respond_to { |format| format.js }
  end

  def select_answer_gamebook
    # when the user clicks in one of the answers from the Gamebook
    # for showing if the answer is right or wrong + explanation:
    set_data_for_answer_after
    # for showing next question:
    set_data_for_next_question
    render :select_answer_gamebook
    # then it renders game_questions > select_answer_gamebook.js.erb automatically
  end

  def select_answer_goal
    # when the user clicks in one of the answers from the Goals
    set_data_for_answer_after
    # then it renders game_questions > select_answer_goal.js.erb automatically
  end

  private

  def game_question_params
    params.require(:game_question).permit(:name, :date, :order, :context, :question, :policy_plan_id)
  end

  def set_game_questions
    @game_questions = GameQuestion.where(policy_plan: @policy_plan)
    @game_questions = @policy_plan.strategy ? @game_questions.order(:order) : @game_questions.order(:date)
  end

  def set_game_answers
    @game_answers = {}
    @game_questions.each do |game_question|
      @game_answers[game_question.id] = GameAnswer.where(game_question: game_question)
    end
  end

  def set_data_for_answer_after
    @game_question = GameQuestion.find(params[:game_question_id])
    @game_answers = GameAnswer.where(game_question: @game_question)
    @selected_answer = GameAnswer.find(params[:game_answer_id])
  end

  def set_data_for_next_question
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    set_game_questions
    @game_question_index = params[:game_question_index].to_i + 1
    @next_question = @game_questions[@game_question_index]
    @next_answers = GameAnswer.where(game_question: @next_question)
  end
end
