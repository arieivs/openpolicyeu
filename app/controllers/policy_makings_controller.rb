class PolicyMakingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

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
  end

  def update
    set_policy_making
    if @policy_making.update(policy_making_params)
      redirect_to policy_making_path(@policy_making)
    else
      render :edit # Probably useless here...
    end
  end

  private

  def set_policy_making
    @policy_making = PolicyMaking.find(params[:id])
  end

  def policy_making_params
    params.require(:policy_making).permit(:country_id, :topic_id, :content, :ambassador_id, :video_url, :video_alt_text, :video_source)
  end
end
