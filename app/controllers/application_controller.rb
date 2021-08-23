class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  # This method has been defined here to be used in PolicyMakings, Questions, and Answers controllers
  def prepare_data_for_policymaking_edit
    @new_question = Question.new # Needed for the 2 question creation forms
    @content_question = @policy_making.questions.find_by(scope: "content") # To display and edit the "content" question (evaluates to nil if no question has been added yet)
    @institutions_question = @policy_making.questions.find_by(scope: "institutions") # To display and edit the "institutions" question (evaluates to nil if no question has been added yet)
    @new_answer = Answer.new # Needed for the answer creation form
  end
end
