class Users::DiariesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @diaries = Diary.page(params[:page]).reverse_order
    @diary_new = Diary.all.order(' created_at DESC ')
    @user = current_user
    @pets = @user.pets
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def show
    @diary = Diary.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @diary_tags = @diary.tags
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def new
    @diary = Diary.new
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def create
    @pet = Pet.find(params[:diary][:pet_id])
    @diary = @pet.diaries.build(diary_params)
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    tag_list = params[:diary][:tag_name].split(nil)
    if @diary.save
      @diary.save_tag(tag_list)
      redirect_to diaries_path, notice: '日記の投稿が完了しました'
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def update
    @diary = Diary.find(params[:id])
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    if @diary.update(diary_params)
      redirect_to diary_path, notice: '日記の編集が完了しました'
    else
      render :edit
    end
  end

  def calenders
    @user = User.find(current_user.id)
    @diaries = @user.diaries
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def bookmarks
    @diary = current_user.bookmark_diaries.page(params[:page]).reverse_order
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end

  def search
    @user = current_user
    @diary_new = Diary.all.order(' created_at DESC ')
    @tag_ranks = Tag.find(TagMiddle.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    @tag = Tag.find(params[:tag_id]) # 参照したタグを取得
    @diaries = @tag.diaries.all      # 参照したタグに紐付けられた投稿を全て表示
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diary_path, notice: '投稿を削除しました'
  end

  private

  def diary_params
    params.require(:diary).permit(:diary_image, :diary_title, :diary_body, :start_time)
  end
end
