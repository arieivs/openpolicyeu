class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:select_answer_quiz]

  def create
    @policy_making = PolicyMaking.find(params[:policy_making_id])
    @new_question = Question.new(question_params)
    @new_question.policy_making = @policy_making
    if @new_question.save
      redirect_to edit_policy_making_path(@policy_making)
    else
      # The following comes from the PolicyMaling#edit controller, and has
      # to be added in order to render 'policy_makings/edit' again...
      prepare_data_for_policymaking_edit # Private method in Application Controller (also called in PolicyMakings & Answers controllers)
      render 'policy_makings/edit'
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to edit_policy_making_path(@question.policy_making)
    else
      render :edit
    end
  end

  def select_answer_quiz
    # when the user clicks in one of the answers from anywhere but the Gamebook
    @question = Question.find(params[:question_id])
    @answers = Answer.where(question: @question)
    @selected_answer = Answer.find(params[:answer_id])
    # then it renders questions > select_answer_quiz.js.erb automatically
  end

  private

  def question_params
    params.require(:question).permit(:question, :scope)
  end
end
