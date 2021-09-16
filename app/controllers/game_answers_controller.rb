class GameAnswersController < ApplicationController
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
