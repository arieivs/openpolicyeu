class InstitutionsController < ApplicationController
  def index
    @institutions = Institution.all
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    # If this action is called from PolicyMakings#edit
    if params[:institution][:policy_making_id].present?
      @policy_making = PolicyMaking.find(params[:institution][:policy_making_id])
      @new_policy_making_institution = PolicyMakingInstitution.new
      @new_institution = Institution.new
      if @institution.save
        respond_to { |format| format.js { flash.now[:notice] = "Institution created! It's ready to be selected above." } }
      else
        respond_to { |format| format.js { flash.now[:alert] = "Please add all required fields to create an Institution." } }
      end
    # If this action is called from PolicyPlans#edit
    elsif params[:institution][:policy_plan_id].present?
      @policy_plan = PolicyPlan.find(params[:institution][:policy_plan_id])
      @new_policy_plan_institution = PolicyPlanInstitution.new
      @new_institution = Institution.new
      if @institution.save
        respond_to { |format| format.js { flash.now[:notice] = "Institution created! It's ready to be selected above." } }
      else
        respond_to { |format| format.js { flash.now[:alert] = "Please add all required fields to create an Institution." } }
      end
    else
      @institution.save ? (redirect_to institutions_path) : (render :new)
    end
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def update
    @institution = Institution.find(params[:id])
    if @institution.update(institution_params)
      redirect_to institutions_path
    else
      render :edit
    end
  end

  private

  def institution_params
    params.require(:institution).permit(:country_id, :name, :website_url, :video_url, :video_alt_text, :video_source, :ambassador_id, :logo)
  end
end
