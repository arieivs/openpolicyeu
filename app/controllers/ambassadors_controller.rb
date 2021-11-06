class AmbassadorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @ambassadors = Ambassador.all
  end
end
