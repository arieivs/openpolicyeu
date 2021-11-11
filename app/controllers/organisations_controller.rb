class OrganisationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @organisations = Organisation.includes({logo_attachment: :blob}, :organisation_countries, :countries, :organisation_topics, :topics, :opportunities, :opportunity_types).order(:name)
    # # Once Select2 library is fully working (not today)
    if params[:organisation_country].present? || params[:organisation_topic].present? || params[:organisation_type].present?
      filter_params = get_filter_params

      @selected_countries = filter_params[:country].split(',').flatten
      get_selected_countries_ids
      @organisations = @organisations.joins(:organisation_countries).where(organisation_countries: {country_id: @selected_countries_ids}) unless @selected_countries_ids.empty?

      @selected_topics = filter_params[:topic].split(',').flatten
      get_selected_topics_ids
      @organisations = @organisations.joins(:organisation_topics).where(organisation_topics: {topic_id: @selected_topics_ids}) unless @selected_topics_ids.empty?

      # @selected_types = filter_params[:type].split(',').flatten
      # get_selected_types_ids
      # @organisations = @organisations.joins(:opportunities).where(opportunities: {opportunity_type_id: @selected_types_ids}) unless @selected_types.empty?

      @organisations = @organisations.uniq
    end
  end

  private

  def get_filter_params
    if params[:organisation_country].present?
      params[:organisation_country]
    elsif params[:organisation_topic].present?
      params[:organisation_topic]
    elsif params[:organisation_type].present?
      params[:organisation_type]
    end
  end

  def get_selected_countries_ids
    @selected_countries_ids = []
    @selected_countries.each do |selected_country|
      country = Country.find_by(name: selected_country)
      @selected_countries_ids << country.id unless country.nil?
    end
  end

  def get_selected_topics_ids
    @selected_topics_ids = []
    @selected_topics.each do |selected_topic|
      topic = Topic.find_by(name: selected_topic)
      @selected_topics_ids << topic.id unless topic.nil?
    end
  end

  def get_selected_types_ids
    @selected_types_ids = []
    @selected_types.each do |selected_type|
      type = OpportunityType.find_by(name: selected_type)
      @selected_types_ids << type.id unless type.nil?
    end
  end
end
