class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    @policy_making = PolicyMaking.new
    if params[:policy_making].present?
      if params[:policy_making][:country_id].empty? || params[:policy_making][:topic_id].empty?
        params[:policy_making][:topic_id].empty? ? flash[:alert] = "Please select a topic" : @policy_making.topic = Topic.find(params[:policy_making][:topic_id])
        params[:policy_making][:country_id].empty? ? flash[:alert] = "Please select a country" : @policy_making.country = Country.find(params[:policy_making][:country_id])
        render :home
      else
        if @policy_making_match = PolicyMaking.find_by(country_id: params[:policy_making][:country_id], topic_id: params[:policy_making][:topic_id])
          redirect_to policy_making_path(@policy_making_match)
        else
          @policy_making.topic = Topic.find(params[:policy_making][:topic_id])
          @policy_making.country = Country.find(params[:policy_making][:country_id])
          flash[:alert] = "Sorry, no policy making has been added yet for this country/topic pair !"
          render :home
        end
      end
    end
    @recent_policy_makings = PolicyMaking.all.order(updated_at: :desc).slice(0..3)
  end

  def about; end
end
