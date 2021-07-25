class Users::PetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @pets = @user.pets.page(params[:page]).reverse_order
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def create
    @pet = current_user.pets.build(pet_params)
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    if @pet.save
      redirect_to pets_path, notice: 'ペットの登録が完了しました'
    else
      render :new
    end
  end

  def edit
    @pet = Pet.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def update
    @pet = Pet.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    if @pet.update(pet_params)
      redirect_to pets_path, notice: 'ペットの編集が完了しました'
    else
      render :edit
    end
  end

  def search
    @pets = Pet.search(params[:search])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
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
