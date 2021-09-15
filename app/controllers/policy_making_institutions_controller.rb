class PolicyMakingInstitutionsController < ApplicationController
  def create
    @policy_making = PolicyMaking.find(params[:policy_making_id])
    @institution = Institution.find(params[:policy_making_institution][:institution_id])
    @policy_making_institution = PolicyMakingInstitution.new(pmi_params)
    @policy_making_institution.policy_making = @policy_making
    @policy_making_institution.institution = @institution
    @policy_making_institution.save
    @new_policy_making_institution = PolicyMakingInstitution.new
    @policy_making_institutions = PolicyMakingInstitution.where(policy_making: @policy_making)
    respond_to { |format| format.js }
  end

  def edit
    @policy_making_institution = PolicyMakingInstitution.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @policy_making_institution = PolicyMakingInstitution.find(params[:id])
    @policy_making_institution.update(pmi_params)
    respond_to { |format| format.js }
  end

  def destroy
    @policy_making_institution = PolicyMakingInstitution.find(params[:id])
    @policy_making = @policy_making_institution.policy_making
    @policy_making_institution.destroy
    @policy_making_institutions = PolicyMakingInstitution.where(policy_making: @policy_making)
    respond_to { |format| format.js }
  end

  private

  def pmi_params
    params.require(:policy_making_institution).permit(:description, :institution_id)
  end
end
