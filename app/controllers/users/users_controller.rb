class Users::UsersController < ApplicationController
  def show
    @user = current_user
    @pets = Pet.all
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to users_path
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_path
  end

  def confirm
  end

  def out
  end

  private
  def user_params
    params.permit(:name, :email, :encrypted_password, :image, :introduction)
  end
end
