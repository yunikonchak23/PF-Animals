class Users::FavoritesController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    favorite = Favorite.new(diary_id: @diary.id, user_id: current_user.id)
    favorite.save
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    favorite = Favorite.find_by(diary_id: @diary.id, user_id: current_user.id)
    favorite.destroy
  end
end
