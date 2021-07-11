class Users::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
  end

  def confirm
  end

  def out
  end
end
