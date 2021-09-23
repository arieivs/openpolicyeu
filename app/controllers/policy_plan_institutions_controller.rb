class PolicyPlanInstitutionsController < ApplicationController
  def create
    @policy_plan = PolicyPlan.find(params[:policy_plan_id])
    @policy_plan_institution = PolicyPlanInstitution.new(ppi_params)
    @policy_plan_institution.policy_plan = @policy_plan
    @new_policy_plan_institution = PolicyPlanInstitution.new
    if params[:policy_plan_institution].present? && !params[:policy_plan_institution][:institution_id].empty?
      @institution = Institution.find(params[:policy_plan_institution][:institution_id])
      @policy_plan_institution.institution = @institution
    end
    save_successful = @policy_plan_institution.save
    @policy_plan_institutions = PolicyPlanInstitution.where(policy_plan: @policy_plan)
    if save_successful
      respond_to { |format| format.js }
    elsif params[:policy_plan_institution][:institution_id].empty?
      respond_to { |format| format.js { flash.now[:alert] = "Please select an Institution." } }
    else
      respond_to { |format| format.js { flash.now[:alert] = "Please describe the role of this Institution." } }
    end
  end

  def edit
    @policy_plan_institution = PolicyPlanInstitution.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @policy_plan_institution = PolicyPlanInstitution.find(params[:id])
    if @policy_plan_institution.update(ppi_params)
      respond_to { |format| format.js }
    else
      render :edit
    end
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
