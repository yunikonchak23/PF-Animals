class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @pets = @user.pets.page(params[:page]).reverse_order
<<<<<<< HEAD
    @diary_new = Diary.joins(pet: :user).where(users: {is_deleted: false}).order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
=======
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
>>>>>>> 17ed1acc2e339b8be0706b990f2dcbd73d97b033
  end

  def edit
    @user = User.find(params[:id])
<<<<<<< HEAD
    @diary_new = Diary.joins(pet: :user).where(users: {is_deleted: false}).order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
=======
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
>>>>>>> 17ed1acc2e339b8be0706b990f2dcbd73d97b033
  end

  def update
    @user = User.find(params[:id])
    @user = current_user
<<<<<<< HEAD
    @diary_new = Diary.joins(pet: :user).where(users: {is_deleted: false}).order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
=======
    @diary_new = Diary.joins(pet: :user).where(users: { is_deleted: false }).order(' created_at DESC ')
    tag_ids = TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id) - Tag.joins(:user).where(users: { is_deleted: true }).pluck(:id)
    @tag_ranks = Tag.find(tag_ids)
>>>>>>> 17ed1acc2e339b8be0706b990f2dcbd73d97b033
    if @user.update(user_params)
      redirect_to user_path, notice: '会員情報の更新に成功しました。'
    else
      render :edit
    end
  end

  def confirm
  end

  def out
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = '退会処理を実行いたしました'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
