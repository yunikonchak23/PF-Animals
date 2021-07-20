class Users::PetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @pets = @user.pets.page(params[:page]).reverse_order
    @diary_new = Diary.all.order(" created_at DESC ")
    @tag_list = Tag.all
  end

  def create
    @pet = current_user.pets.build(pet_params)
    if @pet.save
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  def edit
    @pet = Pet.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(" created_at DESC ")
    @tag_list = Tag.all
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to pets_path
    else
      render :edit
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def pet_params
    params.require(:pet).permit(:image, :pet_name, :type_name, :gender)
  end
end
