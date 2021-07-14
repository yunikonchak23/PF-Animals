class Users::DiariesController < ApplicationController
  def index
    @diaries = Diary.all
    @user = current_user
    @pet = current_user.pets.build
    @diary = current_user.diaries.build
  end

  def show
  end

  def new
    @diary = Diary.new
    @user = current_user
  end

  def create
    @diary = current_user.pets.build(pet_params)
    @diary.save
    redirect_to diaries_path
  end

  def edit
  end

  def updated
  end

  def destroy
  end

  private

  def diary_params
    params.require(:diary).permit(:diary_image, :diary_title, :diary_body)
  end
end
