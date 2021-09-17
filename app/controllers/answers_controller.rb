class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.save
    @new_answer = Answer.new
    respond_to { |format| format.js }
  end

  def edit
    @answer = Answer.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    respond_to { |format| format.js }
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
