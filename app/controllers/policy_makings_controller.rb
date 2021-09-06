class PolicyMakingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :choose_institution]

  def index
    @policy_makings = PolicyMaking.all

    # For the filters (to search for a policymaking in a specific country or topic)
    @policy_making = PolicyMaking.new
    if params[:policy_making].present?
      country_id = params[:policy_making][:country_id]
      topic_id = params[:policy_making][:topic_id]
      @policy_makings = @policy_makings.where(country_id: country_id) unless country_id.empty?
      @policy_makings = @policy_makings.where(topic_id: topic_id) unless topic_id.empty?
    end
  end

  def show
    set_policy_making
    @content_question = Question.where(policy_making: @policy_making).find_by(scope: 'content')
    @content_answers = Answer.where(question: @content_question)
    @policy_making_institutions = PolicyMakingInstitution.where(policy_making: @policy_making)
    @institution_question = Question.where(policy_making: @policy_making).find_by(scope: 'institutions')
    @institution_answers = Answer.where(question: @institution_question)
  end

  def new
    @policy_making = PolicyMaking.new
  end

  def create
    @policy_making = PolicyMaking.new(policy_making_params)
    if @policy_making.save
      redirect_to policy_making_path(@policy_making)
    else
      render :new
    end
  end

  def edit
    set_policy_making
    prepare_data_for_policymaking_edit # Private method in Application Controller (also called in Questions & Answers controllers)
    @policy_making_institution = PolicyMakingInstitution.new
    @institution = Institution.new
    @policy_making_institutions = PolicyMakingInstitution.where(policy_making: @policy_making)
  end

  def update
    set_policy_making
    @policy_making.update(policy_making_params)
    prepare_data_for_policymaking_edit
    respond_to { |format| format.js }
  end

  def choose_institution
    # when the user clicks in one of the institutions cards
    # we call this method and pass the needed ids in the params
    @policy_making = PolicyMaking.find(params[:policy_making_id])
    @policy_making_institutions = PolicyMakingInstitution.where(policy_making: @policy_making)
    @policy_making_institution = PolicyMakingInstitution.find(params[:policy_making_institution_id])
    # then it renders choose_institution.js.erb automatically
    # which in turn renders the institution_description.html.erb partial
  end

  private

  def set_policy_making
    @policy_making = PolicyMaking.find(params[:id])
  end

  def policy_making_params
    params.require(:policy_making).permit(:country_id, :topic_id, :content, :ambassador_id, :video_url, :video_alt_text, :video_source)
  end
end
