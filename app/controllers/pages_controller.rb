class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home; end

  def about; end

  def contribute; end # Page for managing data (creating, updating policy makings...)
end
