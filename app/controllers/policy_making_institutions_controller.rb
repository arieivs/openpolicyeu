class PolicyMakingInstitutionsController < ApplicationController
  def create
    @policy_making = PolicyMaking.find(params[:policy_making_id])
    @policy_making_institution = PolicyMakingInstitution.new(pmi_params)
    @policy_making_institution.policy_making = @policy_making
    @new_policy_making_institution = PolicyMakingInstitution.new
    if params[:policy_making_institution].present? && !params[:policy_making_institution][:institution_id].empty?
      @institution = Institution.find(params[:policy_making_institution][:institution_id])
      @policy_making_institution.institution = @institution
    end
    save_successful = @policy_making_institution.save
    @policy_making_institutions = PolicyMakingInstitution.where(policy_making: @policy_making)
    if save_successful
      respond_to { |format| format.js }
    elsif params[:policy_making_institution][:institution_id].empty?
      respond_to { |format| format.js { flash.now[:alert] = "Please select an Institution." } }
    else
      respond_to { |format| format.js { flash.now[:alert] = "Please describe the role of this Institution." } }
    end
  end

  def edit
    @policy_making_institution = PolicyMakingInstitution.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @policy_making_institution = PolicyMakingInstitution.find(params[:id])
    if @policy_making_institution.update(pmi_params)
      respond_to { |format| format.js }
    else
      render :edit
    end
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
