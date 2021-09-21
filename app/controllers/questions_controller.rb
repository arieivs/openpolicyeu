class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:select_answer_quiz]

  def create
    @policy_making = PolicyMaking.find(params[:policy_making_id])
    @question = Question.new(question_params)
    @question.policy_making = @policy_making
    @new_answer = Answer.new
    if @question.save
      respond_to { |format| format.js }
    end
  end

  def edit
    @question = Question.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @question = Question.find(params[:id])
    @new_answer = Answer.new
    if @question.update(question_params)
      respond_to { |format| format.js }
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question_scope = @question.scope
    @policy_making = @question.policy_making
    @question.destroy
    @new_question = Question.new
    respond_to { |format| format.js }
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
