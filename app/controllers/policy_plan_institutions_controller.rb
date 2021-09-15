class PolicyPlanInstitutionsController < ApplicationController
  def create
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @institution = Institution.find(params[:policy_plan_institution][:institution_id])
    @policy_plan_institution = PolicyPlanInstitution.new(ppi_params)
    @policy_plan_institution.policy_plan = @policy_plan
    @policy_plan_institution.institution = @institution
    @policy_plan_institution.save
    @new_policy_plan_institution = PolicyPlanInstitution.new
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    respond_to { |format| format.js }
  end

  def edit
    @policy_plan_institution = PolicyPlanInstitution.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @policy_plan_institution = PolicyPlanInstitution.find(params[:id])
    @policy_plan_institution.update(ppi_params)
    respond_to { |format| format.js }
  end

  def destroy
    @policy_plan_institution = PolicyPlanInstitution.find(params[:id])
    @policy_plan = @policy_plan_institution.policy_plan
    @policy_plan_institution.destroy
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    respond_to { |format| format.js }
  end

  private

  def ppi_params
    params.require(:policy_plan_institution).permit(:description, :institution_id)
  end
end
