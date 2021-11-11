class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :explore]

  def home
    @recent_policy_makings = PolicyMaking.includes(:topic, country: {flag_attachment: :blob}).order(updated_at: :desc).slice(0..3)
    prepare_data_for_country_topic_filter(:home)
  end

  def about; end

  def explore
    @recent_policy_makings = PolicyMaking.includes(:topic, country: {flag_attachment: :blob}).order(updated_at: :desc).slice(0..3)
    prepare_data_for_country_topic_filter(:explore)
  end

  private

  def prepare_data_for_country_topic_filter(page)
    @policy_making = PolicyMaking.new
    if params[:policy_making].present?
      if params[:policy_making][:country_id].empty? || params[:policy_making][:topic_id].empty?
        set_alert_no_country_topic
        render page
      elsif (@policy_making_match = PolicyMaking.find_by(country_id: params[:policy_making][:country_id], topic_id: params[:policy_making][:topic_id]))
        redirect_to policy_making_path(@policy_making_match)
      else
        set_alert_no_policy_making
        render page
      end
    end
  end

  def set_alert_no_country_topic
    params[:policy_making][:topic_id].empty? ? flash[:alert] = "Please select a topic" : @policy_making.topic = Topic.find(params[:policy_making][:topic_id])
    params[:policy_making][:country_id].empty? ? flash[:alert] = "Please select a country" : @policy_making.country = Country.find(params[:policy_making][:country_id])
  end

  def set_alert_no_policy_making
    @policy_making.topic = Topic.find(params[:policy_making][:topic_id])
    @policy_making.country = Country.find(params[:policy_making][:country_id])
    flash[:alert] = "Sorry, no policy making has been added yet for this country/topic pair!"
  end
end
