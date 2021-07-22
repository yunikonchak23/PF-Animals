class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :out]
  def show
    @user = User.find(params[:id])
    @pets = @user.pets.page(params[:page]).reverse_order
    @diary_new = Diary.all.order(" created_at DESC ")
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def edit
    @user = User.find(params[:id])
    @diary_new = Diary.all.order(" created_at DESC ")
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def update
    @user = User.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(" created_at DESC ")
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    if @user.update(user_params)
      redirect_to user_path, notice: "会員情報の更新に成功しました。"
    else
      render :edit
    end
  end

  def confirm
  end

  def out
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
