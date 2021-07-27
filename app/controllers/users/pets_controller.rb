class Users::PetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @pet = Pet.new
    @pets = @user.pets.page(params[:page]).reverse_order
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
  end

  def create
    @pet = current_user.pets.build(pet_params)
    @user = current_user
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
    if @pet.save
      redirect_to pets_path, notice: 'ペットの登録が完了しました'
    else
      @pets = @user.pets.page(params[:page]).reverse_order
      render :index
    end
  end

  def edit
    @pet = Pet.find(params[:id])
    @user = current_user
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
  end

  def update
    @pet = Pet.find(params[:id])
    @user = current_user
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
    if @pet.update(pet_params)
      redirect_to pets_path, notice: 'ペットの編集が完了しました'
    else
      render :edit
    end
  end

  def search
    @pets = Pet.search(params[:search])
    @user = current_user
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_path
  end

  private

  def pet_params
    params.require(:pet).permit(:image, :pet_name, :type_name, :gender)
  end
end
