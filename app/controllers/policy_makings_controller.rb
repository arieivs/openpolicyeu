class PolicyMakingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @policy_makings = PolicyMaking.includes(:topic, :country).order(:country_id).order(:topic_id)
    # For the filters (to search for a policymaking in a specific country or topic)
    @policy_making = PolicyMaking.new
    if params[:policy_making].present?
      country_id = params[:policy_making][:country_id]
      topic_id = params[:policy_making][:topic_id]
      @policy_makings = @policy_makings.where(country_id: country_id) unless country_id.empty?
      @policy_makings = @policy_makings.where(topic_id: topic_id) unless topic_id.empty?
    end
    @policy_plans_per_pm = {}
    @policy_makings.each do |pm|
      @policy_plans_per_pm[pm.id] = PolicyPlan.where(policy_making: pm)
    end
  end

  def show
    set_policy_making
    @content_question = Question.where(policy_making: @policy_making).find_by(scope: 'content')
    @content_answers = Answer.where(question: @content_question)
    @policy_making_institutions = PolicyMakingInstitution.includes(institution: {logo_attachment: :blob}).where(policy_making: @policy_making)
    @institution_question = Question.where(policy_making: @policy_making).find_by(scope: 'institutions')
    @institution_answers = Answer.where(question: @institution_question)
    @policy_plans = PolicyPlan.where(policy_making: @policy_making)
  end

  def new
    @policy_making = PolicyMaking.new
  end

  def create
    @policy_making = PolicyMaking.new(policy_making_params)
    if @policy_making.save
      redirect_to edit_policy_making_path(@policy_making)
      flash[:notice] = "Policymaking created successfully! Scroll down and keep editing."
    else
      if params[:policy_making][:country_id].empty?
        flash.now[:alert] = "Please select a country."
      elsif params[:policy_making][:topic_id].empty?
        flash.now[:alert] = "Please select a topic."
      elsif PolicyMaking.where(country_id: params[:policy_making][:country_id]).find_by(topic_id: params[:policy_making][:topic_id])
        flash.now[:alert] = "There is already a policymaking page for this country/topic pair!"
      elsif params[:policy_making][:content].empty?
        flash.now[:alert] = "Please describe how does policymaking work in this region/country for this topic."
      end
      render :new
    end
  end

  def edit
    set_policy_making
    prepare_data_for_policymaking_edit
  end

  def update
    set_policy_making
    if @policy_making.update(policy_making_params)
      respond_to { |format| format.js { flash.now[:notice] = "Policymaking updated successfully!" } }
    else
      respond_to { |format| format.js { flash.now[:alert] = "Something went wrong. Please review your inputs above." } }
    end
  end

  private

  def set_policy_making
    @policy_making = PolicyMaking.find(params[:id])
  end

  def policy_making_params
    params.require(:policy_making).permit(:country_id, :topic_id, :content, :ambassador_id, :video_url, :video_alt_text, :video_source)
  end

  def prepare_data_for_policymaking_edit
    @question = Question.new
    @new_answer = Answer.new
    @policy_making_institution = PolicyMakingInstitution.new
    @institution = Institution.new
    @policy_making_institutions = PolicyMakingInstitution.includes(:institution).where(policy_making: @policy_making)
  end
end
