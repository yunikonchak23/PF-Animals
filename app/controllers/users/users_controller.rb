class Users::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_back(fallback_location: root_path)
  end

  def confirm
  end

  def out
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
    
end
