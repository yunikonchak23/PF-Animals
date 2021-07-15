class Users::AnswersController < ApplicationController
  def index
    @answers = Question.all
    @user = current_user
  end
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(user_id: current_user.id, question_id: @question.id, answer_body: params[:answer_body])
    @answer.save
    redirect_to question_path(@question)
  end
  def update
  end
  def destroy
  end

  private
  def answer_params
    params.require(:answer).permit(:answer_body)
  end
end
