class PolicyPlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :choose_institution]

  def show
    set_policy_plan
    @policy_making = @policy_plan.policy_making
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    # if strategy render something different
  end

  private

  def set_policy_plan
    @policy_plan = PolicyPlan.find(params[:id])
  end
end
