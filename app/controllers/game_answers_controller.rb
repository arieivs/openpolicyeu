class GameAnswersController < ApplicationController
  def create
    @game_answer = GameAnswer.new(game_answer_params)
    @game_question = GameQuestion.find(params[:game_question_id])
    @game_answer.game_question = @game_question
    @game_answer.save
    @game_answers = GameAnswer.where(game_question: @game_question)
    @new_game_answer = GameAnswer.new
    respond_to { |format| format.js }
  end

  def edit
    @game_answer = GameAnswer.find(params[:id])
    respond_to { |format| format.js }
  end

  def update
    @game_answer = GameAnswer.find(params[:id])
    @game_answer.update(game_answer_params)
    respond_to { |format| format.js }
  end

  private

  def game_answer_params
    params.require(:game_answer).permit(:context, :answer, :explanation, :right)
  end
end
