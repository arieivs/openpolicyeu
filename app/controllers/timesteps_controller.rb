class TimestepsController < ApplicationController
  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @timestep = Timestep.find(params[:id])
    @policy_plan = @timestep.policy_plan
    @timestep.destroy
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    respond_to { |format| format.js }
  end
end
