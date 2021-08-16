class PolicyMakingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @policy_makings = PolicyMaking.all
  end

  def show
    if params[:country_topic].present? # Request comes from the search bar (home page)
      if params[:country_topic][:country].empty? || params[:country_topic][:topic].empty?
        render 'pages/home' # Should we display error messages ?
      else
        @policy_making = PolicyMaking.find_by(country_id: params[:country_topic][:country], topic_id: params[:country_topic][:topic])
      end
    else # Request comes from a link (or redirection after create, etc.)
      set_policy_making
    end
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
