class QuestionsController < ApplicationController
  def create
    @policy_making = PolicyMaking.find(params[:policy_making_id])
    @question = Question.new(question_params)
    @question.policy_making = @policy_making
    if @question.save
      redirect_to edit_policy_making_path(@policy_making)
    else
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

  private

  def question_params
    params.require(:question).permit(:question, :scope)
  end
end
