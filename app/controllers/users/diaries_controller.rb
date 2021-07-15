class Users::DiariesController < ApplicationController
  def index
    @diaries = Diary.all
    @user = current_user
    @pet = current_user.pets.build
  end

  def show
  end

  def new
    @diary = Diary.new
    @user = current_user
  end

  def create
<<<<<<< HEAD
    @diary = current_user.pets.build
=======
    @pet = Pet.find(params[:diary][:pet_id])
    @diary = @pet.diaries.build(diary_params)
>>>>>>> 3878a718607dbf3aa442d5d1b6bb39099881d3a0
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
