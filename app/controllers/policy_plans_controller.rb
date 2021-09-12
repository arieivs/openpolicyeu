class PolicyPlansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :choose_institution]

  def show
    set_policy_plan
    @policy_making = @policy_plan.policy_making
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    @goals = Goal.where(policy_plan: @policy_plan).order(:order)
    @timesteps = Timestep.where(policy_plan: @policy_plan).order(:date)
    @game_questions = GameQuestion.where(policy_plan: @policy_plan).order(:order)
  end

  def choose_institution
    # when the user clicks in one of the institutions cards
    # we call this method and pass the needed ids in the params
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    @policy_plan_institution = PolicyPlanInstitution.find(params[:policy_plan_institution_id])
    # then it renders choose_institution.js.erb automatically
    # which in turn renders the institution_description.html.erb partial
  end

  private

  def set_policy_plan
    @policy_plan = PolicyPlan.find(params[:id])
  end
end
