class Users::AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @question.answers.create(answer_params)
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params[:answer][:user_id] = current_user.id
    params.require(:answer).permit(:answer_body, :user_id)
  end
end
