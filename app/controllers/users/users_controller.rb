class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :out]
  def show
    @user = User.find(params[:id])
    @pets = @user.pets
    @diaries = Diary.all.order(" created_at DESC ")
  end

  def edit
    @user = User.find(params[:id])
    @diaries = Diary.all.order(" created_at DESC ")
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
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
    redirect_to root_path
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
