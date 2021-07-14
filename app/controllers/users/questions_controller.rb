class Users::QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end
  
  def show
  end
  
  def new
    @question = Question.new
  end
  
  def edit
  end
  
  def create
    @question = current_user.questions.build(question_params)
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def question_params
    params.require(:question).permit(:question_title, :questionbody)
  end
end
