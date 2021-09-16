class TimestepsController < ApplicationController
  def create
    @timestep = Timestep.new(timestep_params)
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @timestep.policy_plan = @policy_plan
    @timestep.save
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    @new_timestep = Timestep.new
    respond_to { |format| format.js }
  end

  def edit
    @timestep = Timestep.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @timestep = Timestep.find(params[:id])
    @timestep.update(timestep_params)
    @policy_plan = @timestep.policy_plan
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    respond_to { |format| format.js }
  end

  def destroy
    @timestep = Timestep.find(params[:id])
    @policy_plan = @timestep.policy_plan
    @timestep.destroy
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    respond_to { |format| format.js }
  end

  private

  def timestep_params
    params.require(:timestep).permit(:date, :name, :description, :policy_plan_id)
  end
end