class GoalsController < ApplicationController
  def create
    @goal = Goal.new(goal_params)
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @goal.policy_plan = @policy_plan
    save_successful = @goal.save
    prepare_data_for_goals_edit_pp
    @new_goal = Goal.new
    @new_goal_order = @goal.order + 1
    if save_successful
      respond_to { |format| format.js }
    else
      respond_to { |format| format.js { flash.now[:alert] = "Please add all the required fields to create a goal." } }
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      respond_to { |format| format.js }
    else
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @policy_plan = @goal.policy_plan
    @goal.destroy
    prepare_data_for_goals_edit_pp
    respond_to { |format| format.js }
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :order, :description)
  end

  def prepare_data_for_goals_edit_pp
    @goals = Goal.where(policy_plan: @policy_plan).order(:order)
    @goals_n_games = []
    @goals.each do |goal|
      game_question = GameQuestion.where(policy_plan: @policy_plan).find_by(order: goal.order)
      game_answers = GameAnswer.where(game_question: game_question)
      @goals_n_games.push({ goal: goal, game_question: game_question, game_answers: game_answers })
    end
    @new_game_question = GameQuestion.new
    @new_game_answer = GameAnswer.new
  end
end
