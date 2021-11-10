class VolunteersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @volunteers = Volunteer.all.includes(photo_attachment: :blob).order(:id)
  end
end
