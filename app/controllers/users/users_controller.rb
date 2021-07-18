class Users::UsersController < ApplicationController
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
    @user.update(user_params)
    redirect_to user_path
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
end
