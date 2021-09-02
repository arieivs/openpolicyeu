class AnswersController < ApplicationController
  def create
    @policy_making = PolicyMaking.find(params[:policy_making_id])
    @question = Question.find(params[:question_id])
    @new_answer = Answer.new(answer_params)
    @new_answer.question = @question
    if @new_answer.save
      redirect_to edit_policy_making_path(@policy_making)
    else
      # The following comes from the PolicyMaling#edit controller, and has
      # to be added in order to render 'policy_makings/edit' again...
      prepare_data_for_policymaking_edit # Private method in Application Controller (also called in PolicyMakings & Questions controllers)
      render 'policy_makings/edit'
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to edit_policy_making_path(@answer.question.policy_making)
    else
      render :edit
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :explanation, :right)
  end
end
