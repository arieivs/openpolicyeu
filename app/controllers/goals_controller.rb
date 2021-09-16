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

  private

  def goal_params
    params.require(:goal).permit(:name, :order, :description)
  end
end
