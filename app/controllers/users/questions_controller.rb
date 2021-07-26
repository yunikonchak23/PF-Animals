class Users::QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @questions = Question.page(params[:page]).reverse_order
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def show
    @question = Question.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def new
    @question = Question.new
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def edit
    @question = Question.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def create
    @question = current_user.questions.build(question_params)
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    if @question.save
      redirect_to questions_path, notice: '質問の投稿が完了しました'
    else
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    if @question.update(question_params)
      redirect_to question_path, notice: '質問の編集が完了しました'
    else
      render :edit
    end
  end

  def history
    @user = current_user
    @questions = @user.questions.page(params[:page]).reverse_order
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:question_title, :question_body, :is_active)
  end
end
