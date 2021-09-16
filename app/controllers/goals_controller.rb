class GoalsController < ApplicationController
  def edit
    @goal = Goal.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
    respond_to { |format| format.js }
  end

  def destroy
    @goal = Goal.find(params[:id])
    @policy_plan = @goal.policy_plan
    @goal.destroy
    @goals = Goal.where(policy_plan: @policy_plan).order(:order)
    @goals_n_games = []
    @goals.each do |goal|
      game_question = GameQuestion.where(policy_plan: @policy_plan).find_by(order: goal.order)
      game_answers = GameAnswer.where(game_question: game_question)
      @goals_n_games.push({ goal: goal, game_question: game_question, game_answers: game_answers })
    end
    @new_game_answer = GameAnswer.new
    respond_to { |format| format.js }
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :order, :description)
  end
end
