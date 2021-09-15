class PolicyPlanInstitutionsController < ApplicationController
  def edit
    @policy_plan_institution = PolicyPlanInstitution.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @policy_plan_institution = PolicyPlanInstitution.find(params[:id])
    @policy_plan_institution.update(ppi_params)
    respond_to { |format| format.js }
  end

  private

  def ppi_params
    params.require(:policy_plan_institution).permit(:description, :institution_id)
  end
end
