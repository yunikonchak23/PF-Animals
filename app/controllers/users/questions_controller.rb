class Users::QuestionsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  def index
    @questions = Question.all
    @user = current_user
  end

  def show
    @question = Question.find(params[:id])
    @user = current_user
  end

  def new
    @question = Question.new
    @user = current_user
  end

  def edit
    @question = Question.find(params[:id])
    @user = current_user
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:question_title, :question_body)
  end
end
