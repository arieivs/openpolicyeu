class InstitutionsController < ApplicationController

  def index
    @institutions = Institution.all
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)

    if params[:institution][:policy_making_id].present? #If this action is called from PolicyMakings#edit
      @policy_making = PolicyMaking.find(params[:institution][:policy_making_id])
      @institution.save
      @new_policy_making_institution = PolicyMakingInstitution.new
      respond_to { |format| format.js }
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
    params.require(:institution).permit(:country_id, :name, :website_url, :video_url, :video_alt_text, :video_source, :ambassador_id)
  end

end
