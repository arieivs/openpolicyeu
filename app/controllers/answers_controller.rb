class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @new_answer = Answer.new
    if @answer.save
      respond_to { |format| format.js }
    else
      respond_to { |format| format.js { flash.now[:alert] = "Please add all the required fields to create an answer." } }
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      respond_to { |format| format.js }
    else
      render :edit
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @policy_making = @question.policy_making
    @answer.destroy
    @new_answer = Answer.new
    respond_to { |format| format.js }
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :explanation, :right)
  end
end
