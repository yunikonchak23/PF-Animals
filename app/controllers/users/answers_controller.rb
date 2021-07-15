class Users::AnswersController < ApplicationController
  def index
    @answers = Question.all
    @user = current_user
  end
  def create 
    @answer = current_user.answers.new(answer_params)
    @answer.save
    redirect_to questions_path
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
