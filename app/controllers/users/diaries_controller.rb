class Users::DiariesController < ApplicationController
  before_action :authenticate_user!,except: [:index]

  def index
    @diaries = Diary.all.order(" created_at DESC ")
    @user = current_user
    @pets = @user.pets
  end

  def show
    @diary = Diary.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @diaries = Diary.all.order(" created_at DESC ")
  end

  def new
    @diary = Diary.new
    @user = current_user
    @diaries = Diary.all.order(" created_at DESC ")
  end

  def create
    @pet = Pet.find(params[:diary][:pet_id])
    @diary = @pet.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    @user = current_user
    @diaries = Diary.all.order(" created_at DESC ")
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diary_path
    else
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diary_path
  end

  private

  def diary_params
    params.require(:diary).permit(:diary_image, :diary_title, :diary_body)
  end
end
