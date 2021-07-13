class Users::PetsController < ApplicationController
  def index
    @pet = Pet.new
    @user = current_user
    @pets = Pet.all
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.save
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def pet_params
    params.require(:pet).permit(:pet_image, :pet_name, :type_name, :gender)
  end
end
