class Users::PetsController < ApplicationController
  def show
    @pet = current_user.pets.build
    @user = current_user
    @pets = @user.pets
    @diaries = Diary.all.order(" created_at DESC ")
  end

  def create
    @pet = current_user.pets.build(pet_params)
    @pet.save
    redirect_back(fallback_location: root_path)
  end

  def edit
    @pet = Pet.find(params[:id])
    @diaries = Diary.all.order(" created_at DESC ")
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    redirect_to pet_path
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
